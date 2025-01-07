composer create-project --no-progress --prefer-dist --repository=https://repo.magento.com/ magento/project-community-edition  . && \
if mv project-community-edition/* .; then
    rm -rf project-community-edition
else
    echo "Failed to move files from project-community-edition"
    exit 1
fi && \
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
    --page-cache-redis-db=1 && \
read -p "Do you want to deploy sample data? (y/n): " deploy_sampledata
if [ "$deploy_sampledata" = "y" ]; then
    php bin/magento sampledata:deploy && \
[ -d "generated" ] && rm -rf generated/* && \
php bin/magento setup:upgrade && \
php bin/magento cache:flush && \
rm -rf generated/* && \
chmod +x bin/magento && \
bin/magento deploy:mode:set production  && \