#!/usr/bin/env node

const { execSync } = require("child_process");

const args = process.argv.slice(2);
const command = args.join(" ");

const scripts = {
  start: "docker-compose up --build",
  stop: "docker-compose down",
  logs: "docker-compose logs",
  install: "docker exec -it magento-php bash -c 'sh install.sh'",
  "flush-cache": "docker exec -it magento-php bash -c 'bin/magento cache:flush'",
  "deploy-sampledata": "docker exec -it magento-php bash -c 'bin/magento sampledata:deploy'"
};

if (scripts[command]) {
  try {
    console.log(`Running: ${scripts[command]}`);
    execSync(scripts[command], { stdio: "inherit" });
  } catch (error) {
    console.error("Error running command:", error.message);
  }
} else {
  console.log("Available commands:");
  Object.keys(scripts).forEach((cmd) => console.log(`  - ${cmd}`));
}
