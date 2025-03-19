# dbt Environment Setup

This repository provides a simple way to set up multiple dbt environments with separate virtual environments and environment variables.

## 📌 Features
- Manage multiple dbt environments (`dev`, `prod`).
- Automatically activate the correct virtual environment.
- Load the right environment variables.
- Install dbt inside the active environment only when needed.

## 🚀 Installation

### 1️⃣ Clone the Repository
```sh
git clone https://github.com/YOUR_GITHUB_USERNAME/dbt-env-setup.git
cd dbt-env-setup```

### 2️⃣ Create Virtual Environments

mkdir -p envs
python3 -m venv envs/dev
python3 -m venv envs/prod

### 3️⃣ Set Up an Environment

To activate dev:

source scripts/dbt_setup.sh dev

To activate prod:

source scripts/dbt_setup.sh prod

### 4️⃣ Install dbt (If Needed)

Once your environment is active, run:

bash install_dbt.sh
