#!/bin/bash
# Script to prepare and push The Shelter Landing Page to GitHub

echo "The Shelter Landing Page - GitHub Setup Script"
echo "=============================================="
echo ""
echo "This script will help you push the landing page to GitHub"
echo ""

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "Error: package.json not found. Please run this from the frontend directory"
    exit 1
fi

# Initialize git if not already done
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
    git branch -M main
fi

# Create .gitignore if it doesn't exist
if [ ! -f ".gitignore" ]; then
    cat > .gitignore << 'EOF'
node_modules/
/.pnp
.pnp.js
/coverage
/build
.DS_Store
.env
.env.local
.env.development.local
.env.test.local
.env.production.local
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.idea/
.vscode/
*.swp
*.swo
*~
EOF
    echo "✓ Created .gitignore"
fi

# Add all files
echo "Adding files to git..."
git add .

# Commit
echo "Creating initial commit..."
git commit -m "Initial commit: The Shelter landing page with Minecraft, Ark, and Palworld sections"

# Prompt for GitHub repository URL
echo ""
echo "=============================================="
echo "Now create a new repository on GitHub:"
echo "1. Go to: https://github.com/new"
echo "2. Repository name: shelter-landing-page"
echo "3. Make it Private (recommended)"
echo "4. DO NOT initialize with README"
echo "5. Click 'Create repository'"
echo ""
read -p "Have you created the repository? (y/n): " created

if [ "$created" != "y" ]; then
    echo "Please create the repository first, then run this script again"
    exit 0
fi

read -p "Enter your GitHub username: " username
read -p "Enter repository name (default: shelter-landing-page): " reponame
reponame=${reponame:-shelter-landing-page}

REPO_URL="https://github.com/$username/$reponame.git"

echo ""
echo "Adding remote repository..."
git remote add origin "$REPO_URL"

echo "Pushing to GitHub..."
git push -u origin main

echo ""
echo "=============================================="
echo "✓ Successfully pushed to GitHub!"
echo "=============================================="
echo ""
echo "Repository URL: $REPO_URL"
echo ""
echo "Next: Clone on your server"
echo "Run on your server:"
echo ""
echo "  git clone $REPO_URL /var/www/theshelter"
echo "  cd /var/www/theshelter"
echo "  yarn install"
echo "  yarn build"
echo "  sudo cp -r build/* /var/www/html/"
echo ""
