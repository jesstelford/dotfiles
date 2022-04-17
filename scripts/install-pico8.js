const fs = require("node:fs/promises");
const { chromium } = require("playwright");
const path = require("node:path");

if (!process.env.DEST_FILE) {
  throw new Error("DEST_FILE must be specified");
}

if (!process.env.USERNAME) {
  throw new Error("USERNAME must be specified");
}

if (!process.env.PASSWORD) {
  throw new Error("PASSWORD must be specified");
}

if (!process.env.PLATFORM) {
  throw new Error("PLATFORM must be specified");
}

const platformSelectors = {
  osx: "_osx.zip",
  linux: "_i386.zip",
  linux64: "_amd64.zip",
  rpi: "_raspi.zip",
};

(async () => {
  const browser = await chromium.launch({ headless: false });
  const page = await browser.newPage();

  // Login
  await page.goto("https://itch.io/login");
  await page.locator('input[name="username"]').fill(process.env.USERNAME);
  await page.locator('input[name="password"]').fill(process.env.PASSWORD);
  await Promise.all([
    page.waitForNavigation(),
    page.locator('button:text("Log in"):not(.github_login_btn)').click(),
  ]);

  // Download PICO-8
  await page.goto("https://lexaloffle.itch.io/pico-8");
  await Promise.all([
    page.waitForNavigation(),
    page.locator('a:text("Download")').click(),
  ]);

  const [download] = await Promise.all([
    // Wait for the download triggerd by the following locator
    page.waitForEvent("download"),
    // Click the Download button for Linux
    page
      .locator(`.upload:has-text("${platformSelectors[process.env.PLATFORM]}")`)
      .locator('a:text("Download")')
      .click(),
  ]);

  // Persist the download to the destination file
  const tmpFilePath = await download.path();
  await fs.mkdir(path.dirname(process.env.DEST_FILE), { recursive: true });
  await fs.copyFile(tmpFilePath, process.env.DEST_FILE);

  // Logout
  await page.locator('[aria-label="Account Menu"]').click();
  await Promise.all([
    page.waitForNavigation(),
    page.locator("text=Log out").click(),
  ]);

  await browser.close();
})();
