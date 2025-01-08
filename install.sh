#!/bin/bash

# Step 1: Create Magento Project
echo "Creating Magento project..."
composer create-project --no-progress --prefer-dist --repository=https://repo.magento.com/ magento/project-community-edition || {
    echo "Error: Failed to create Magento project."
    exit 1
}

# Step 2: Move Files from Project Directory (if exists)
if [ -d "project-community-edition" ]; then
    echo "Moving files from project-community-edition to the current directory..."
    mv project-community-edition/* . || {
        echo "Error: Failed to move files from project-community-edition."
        exit 1
    }
    rm -rf project-community-edition
fi

# Step 3: Magento Setup Installation
echo "Starting Magento setup installation..."
php bin/magento setup:install \
    --base-url=http://local.magento.com \
    --base-url-secure=https://local.magento.com \
    --use-secure=1 \
    --use-secure-admin=1 \
    --db-host=mysql \
    --db-name=magento \
    --db-user=magento \
    --db-password=magento \
    --admin-firstname=admin \
    --admin-lastname=admin \
    --admin-email=admin@example.com \
    --admin-user=admin \
    --admin-password=admin123 \
    --language=en_US \
    --currency=USD \
    --timezone=America/New_York \
    --use-rewrites=1 \
    --search-engine=elasticsearch7 \
    --elasticsearch-host=elasticsearch \
    --elasticsearch-port=9200 \
    --session-save=redis \
    --session-save-redis-host=redis \
    --session-save-redis-port=6379 \
    --cache-backend=redis \
    --cache-backend-redis-server=redis \
    --cache-backend-redis-db=0 \
    --page-cache=redis \
    --page-cache-redis-server=redis \
    --page-cache-redis-port=6379 \
    --page-cache-redis-db=1 || {
        echo "Error: Magento setup installation failed."
        exit 1
    }

# Step 4: Optional Sample Data Deployment
read -p "Do you want to deploy sample data? (y/n): " deploy_sampledata
if [ "$deploy_sampledata" == "y" ]; then
    echo "Deploying sample data..."
    php bin/magento sampledata:deploy || {
        echo "Error: Sample data deployment failed."
        exit 1
    }
fi

# Step 5: Final Setup Commands
echo "Running setup upgrade and cache flush..."
[ -d "generated" ] && rm -rf generated/* # Clear generated directory
php bin/magento setup:upgrade || { echo "Error: Setup upgrade failed."; exit 1; }
php bin/magento cache:flush || { echo "Error: Cache flush failed."; exit 1; }
rm -rf generated/*

# Step 6: Set Magento to Production Mode
echo "Setting Magento to production mode..."
php bin/magento deploy:mode:set production --progress || {
    echo "Error: Failed to set production mode."
    exit 1
}

echo "Magento installation and setup complete!"
