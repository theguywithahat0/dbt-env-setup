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
cd dbt-env-setup

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
### **📌 File: `install_dbt.sh`**
Filename: **`install_dbt.sh`**

**Contents:**
```sh
#!/bin/bash

# Script to install specific versions of dbt packages using pip

# Array of package names with versions
packages=(
    "dbt-core==1.9.2"
    "dbt-bigquery==1.9.1"
    "dbt-duckdb==1.9.2"
)

# Loop through the package list and install each one
for package in "${packages[@]}"; do
    echo "Installing ${package}..."
    pip install "$package"
done

echo "All packages installed successfully."
