# Magento Docker Setup

This repository provides a comprehensive Dockerized setup for installing and managing Magento 2 with essential services like MySQL, Redis, Elasticsearch, and Nginx. It simplifies the process of setting up a local development environment for Magento 2.

## Features
- Docker Compose configuration for Magento services
- Pre-configured Nginx with SSL support
- Support for Redis for caching and session management
- Elasticsearch integration for advanced search functionality
- Install scripts for seamless Magento installation

---

## Prerequisites
Before you begin, ensure you have the following installed:
1. Docker: [Install Docker](https://docs.docker.com/get-docker/)
2. Docker Compose: [Install Docker Compose](https://docs.docker.com/compose/install/)
3. Composer: [Install Composer](https://getcomposer.org/download/)

---

## Installation

### 1. Clone the Repository
```sh
git clone https://github.com/vinaysikarwar/magento-docker-setup.git
cd magento-docker-setup
```

### 2. Build and Start the Containers
```sh
docker compose up --build
```

### 3. Access the PHP Container
```sh
docker exec -it magento-php bash
```

### 4. Run the Magento Installation Script
Inside the container, run:
```sh
sh install.sh
```

The script will:
- Install Magento using Composer
- Set up the database
- Configure Redis and Elasticsearch
- Optionally deploy sample data

---

## Accessing Magento
- **Frontend URL:** [http://local.magento.com](http://local.magento.com)
- **Admin URL:** [http://local.magento.com/admin](http://local.magento.com/admin)
    - **Admin Login**
        - **Username:** admin

---

## SSL Configuration
The setup includes pre-generated SSL certificates for HTTPS. Access the secure URL at:
- [https://local.magento.com](https://local.magento.com)

---

## Services Overview
The following services are configured in the `docker-compose.yml` file:
- **MySQL:** Handles Magento's database.
- **Redis:** Manages caching and session storage.
- **Elasticsearch:** Provides advanced search capabilities.
- **Nginx:** Web server for serving Magento.
- **PHP-FPM:** Executes Magento's PHP scripts.

---

## Contributing
Contributions are welcome! Please fork this repository and submit a pull request.

---

## License
This project is licensed under the MIT License. See [LICENSE](LICENSE) for more information.

---

You can save this as `README.md` in your GitHub repository. It’s structured for developers and easy to understand, ensuring they can set up the environment without hassle.
