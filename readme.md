```md
# Environment Setup

This repository provides a simple and neutral solution for managing multiple project environments. It offers:

- **Separate environment variable files** for different environments (e.g., `dev` and `prod`).
- **Virtual environment folder structure** (with a default placeholder) so that users can create and use their own virtual environments.
- A **setup script** to load environment variables and (optionally) activate the correct virtual environment.
- An **install script** to install core dependencies (e.g., dbt-core) in the active environment.
- A **sample shell configuration file** (`.bash_aliases.sample`) with aliases and functions to ease your workflow.

> **Note:** Environment variables are optional. The setup script will load them if they exist and otherwise continue without error.

---

## Repository Structure

```
environment-setup/
├── env_vars/             
│   ├── dev.env           # Environment variables for development
│   ├── prod.env          # Environment variables for production
├── envs/                 
│   ├── .gitkeep          # Placeholder file to maintain folder structure (venv contents are ignored)
├── scripts/              
│   ├── project_setup.sh  # Script to load environment variables and set up your environment
├── install_dbt.sh        # Script to install dbt-core (and its dependencies) in the active environment
├── .bash_aliases.sample  # Sample aliases and functions for your shell configuration
├── .gitignore            # Git ignore rules
└── README.md             # This file
```

---

## Getting Started

### 1. Clone the Repository

```sh
git clone https://github.com/YOUR_GITHUB_USERNAME/environment-setup.git
cd environment-setup
```

### 2. Create Virtual Environments

Even though the `envs/` folder is provided, it is empty. Create your virtual environments as needed. For example, to create a default and two named environments:

```sh
# Create a default environment (for backup)
python3 -m venv envs/env

# Create a development environment
python3 -m venv envs/dev

# Create a production environment
python3 -m venv envs/prod
```

### 3. Set Up an Environment

Use the provided setup script to load environment variables and prepare your shell. The script is located at `scripts/project_setup.sh`.

For example, to set up the **development** environment:

```sh
source scripts/project_setup.sh dev
```

Or for the **production** environment:

```sh
source scripts/project_setup.sh prod
```

> The script will:
>
> - Look for environment variable files in `env_vars/` (e.g., `dev.env` or `prod.env`).  
> - Load them if they exist (if not, it will continue without error).  
> - (Optionally) Activate the corresponding virtual environment if you customize the script to do so.

### 4. Install Core Dependencies (Optional)

After setting up your environment and activating your virtual environment, you can install the core dependency using the install script:

```sh
bash install_dbt.sh
```

This script installs `dbt-core` (and its dependencies) in your active virtual environment.

---

## Optional: Shell Aliases and Functions

A sample shell configuration file, `.bash_aliases.sample`, is provided in this repository. It includes:

- An alias to run the project setup script easily.
- An alias to activate a default virtual environment.
- A function (`load_env`) that loads environment variables from a file if it exists.

### To Use the Sample File

1. Copy (or merge) the sample file into your home directory:

   ```sh
   cp .bash_aliases.sample ~/.bash_aliases
   ```

2. Reload your shell configuration:

   ```sh
   source ~/.bash_aliases
   ```

Now you can use commands such as:

- `project_setup dev` – to run the setup script for the development environment.
- `env_default` – to activate the default virtual environment.
- `load_env dev` – to manually load the environment variables for development (if needed).

---

## Environment Variable Files

The repository includes two example environment variable files:

### `env_vars/dev.env`

```ini
DBT_ENV=dev
SAMPLE_VAR_1=1
```

### `env_vars/prod.env`

```ini
DBT_ENV=prod
SAMPLE_VAR_1=2
```

Feel free to modify these files to suit your project's needs. Remember that these files are optional—if they don't exist, the setup script will notify you and continue.

---

## Additional Notes

- **Customization:** You can customize the paths and commands in the setup script (`scripts/project_setup.sh`) to suit your specific project layout.
- **Virtual Environments:** The `envs/` folder is tracked only as an empty folder (via the `.gitkeep` file). Actual virtual environment files are not tracked.
- **Profiles:** If your project uses additional configuration (e.g., a profiles file), set the appropriate environment variable (for example, `export PROFILES_DIR=~/environment-setup/.profiles`) in your shell or within your setup script.

---

## Summary

This repository is designed to be a neutral, portable starting point for managing multiple environments with separate environment variables and virtual environments. Whether you're setting up a development or production environment, the provided scripts and sample files are here to help streamline your workflow.

Happy setting up!
```
