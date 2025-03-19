#!/bin/bash

# Improved DBT environment setup script
# Usage: source dbt_setup.sh dev | source dbt_setup.sh prod

# Ensure we're being sourced, not executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "Error: This script must be sourced, not executed."
    echo "Usage: source dbt_setup.sh <environment>"
    exit 1
fi

# Check for required argument
if [ -z "$1" ]; then
    echo "Error: Missing environment argument."
    echo "Usage: source dbt_setup.sh <environment>"
    return 1
fi

ENV_NAME="$1"

# Define paths using reliable path resolution
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"
ENV_VARS_FILE="$BASE_DIR/env_vars/$ENV_NAME.env"
VENV_DIR="$BASE_DIR/envs/$ENV_NAME"
DBT_PROJECT_DIR="$BASE_DIR/dbt_project"  # Change this if needed

# Check if virtual environment exists
if [ ! -d "$VENV_DIR" ]; then
    echo "Error: Virtual environment '$VENV_DIR' not found!"
    echo "Please create it using: python3 -m venv $VENV_DIR"
    return 1
fi

# Load environment variables if file exists
if [ -f "$ENV_VARS_FILE" ]; then
    set -a  # Automatically export all variables
    source "$ENV_VARS_FILE"
    set +a  # Turn off auto-export
    echo "✅ Loaded environment variables from $ENV_VARS_FILE"
else
    echo "⚠️  Warning: Environment file '$ENV_VARS_FILE' not found; proceeding without loading env vars."
fi

# Activate the virtual environment
source "$VENV_DIR/bin/activate"
echo "✅ Activated virtual environment: $VENV_DIR"

# Check if DBT project directory exists before changing to it
if [ -d "$DBT_PROJECT_DIR" ]; then
    cd "$DBT_PROJECT_DIR"
    echo "✅ Changed directory to: $DBT_PROJECT_DIR"
else
    echo "⚠️  Warning: DBT project directory '$DBT_PROJECT_DIR' not found."
    echo "    Remaining in current directory: $(pwd)"
fi

echo "🚀 Your $ENV_NAME environment is ready!"
