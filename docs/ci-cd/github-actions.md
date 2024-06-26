---
sidebar_position: 3
---

# GitHub Actions

```yaml
name: Deploy build to GitHub Pages

on:
  push:
    branches:
      - main

permissions:
  contents: write

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout
      uses: actions/checkout@v2

    - name: Set up Node.js
      uses: actions/setup-node@v1
      with:
        node-version: '18'

    - name: Install Dependencies
      run: npm install

    - name: Build
      run: npm run build

    - name: Set up SSH Agent
      uses: webfactory/ssh-agent@v0.5.1
      with:
        ssh-private-key: ${{ secrets.DEPLOY_KEY }}

    - name: Deploy
      run: |
        # Set up git with your name and email
        git config --global user.name 'Andrii Bondariev'
        git config --global user.email 'andreybond13@gmail.com'

        # Clone the target repository
        git clone git@github.com:andreasblaze/andreasblaze.github.io.git
        cd andreasblaze.github.io
        git checkout main
        
        # Clean out existing contents
        find . -maxdepth 1 ! -name '.git' ! -name '.' ! -name '..' -exec rm -rf {} \;
        
        # Copy build directory contents to the repo root
        cp -a ../build/* ./
        
        # Commit and push changes to the target repository
        git add .
        git commit -m "Deploy to GitHub Pages"
        git push origin main
```