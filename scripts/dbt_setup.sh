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

# Load environment variables first so we can use them to determine project path
if [ -f "$ENV_VARS_FILE" ]; then
    set -a  # Automatically export all variables
    source "$ENV_VARS_FILE"
    set +a  # Turn off auto-export
    echo "✅ Loaded environment variables from $ENV_VARS_FILE"
else
    echo "⚠️  Warning: Environment file '$ENV_VARS_FILE' not found; proceeding without loading env vars."
fi

# Determine DBT project directory based on environment
# If DBT_PROJECT_PATH is defined in the environment file, use it
# Otherwise fall back to default
if [ -n "$DBT_PROJECT_PATH" ]; then
    DBT_PROJECT_DIR="$DBT_PROJECT_PATH"
    echo "👉 Using project path from environment: $DBT_PROJECT_DIR"
else
    DBT_PROJECT_DIR="$BASE_DIR/dbt_project"
    echo "👉 Using default project path: $DBT_PROJECT_DIR"
fi

# Set DBT_PROFILES_DIR to point to the centralized profiles if the directory exists
if [ -d "$BASE_DIR/.dbt" ]; then
    export DBT_PROFILES_DIR="$BASE_DIR/.dbt"
    echo "📂 Using custom profiles directory: $DBT_PROFILES_DIR"
    echo "⚠️  IMPORTANT: This overrides the default ~/.dbt/profiles.yml location"
else
    echo "📂 Using default profiles directory: ~/.dbt"
fi

# Check if virtual environment exists
if [ ! -d "$VENV_DIR" ]; then
    echo "Error: Virtual environment '$VENV_DIR' not found!"
    echo "Please create it using: python3 -m venv $VENV_DIR"
    return 1
fi

# Activate the virtual environment
source "$VENV_DIR/bin/activate"
echo "✅ Activated virtual environment: $VENV_DIR"

# Check if DBT project directory exists before changing to it
if [ -d "$DBT_PROJECT_DIR" ]; then
    cd "$DBT_PROJECT_DIR"
    echo "✅ Changed directory to: $DBT_PROJECT_DIR"
else
    echo "⚠️  Warning: DBT project directory '$DBT_PROJECT_DIR' does not exist."
    echo "    Environment variables are loaded and virtual environment is activated,"
    echo "    but you'll need to manually navigate to your project directory."
    echo "    Current directory: $(pwd)"
fi

echo "🚀 Your $ENV_NAME environment is ready!"
