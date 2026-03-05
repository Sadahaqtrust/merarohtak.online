#!/bin/bash

# Backup the current Nginx configuration
echo "Backing up current Nginx configuration..."
sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak

# Ensure the sites-available and sites-enabled directories exist
echo "Ensuring /etc/nginx/sites-available and /etc/nginx/sites-enabled directories exist..."
sudo mkdir -p /etc/nginx/sites-available
sudo mkdir -p /etc/nginx/sites-enabled

# Create the new Nginx configuration for merarohtak.online
echo "Creating new Nginx configuration for merarohtak.online..."

sudo tee /etc/nginx/sites-available/merarohtak.online.conf > /dev/null << 'EOF'
server {
    listen 80;
    server_name merarohtak.online;
    root /home/opc/Food-Delivery/public;

    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ ^/index.php {
        fastcgi_pass unix:/var/run/php/php-fpm.sock; # Adjust this if you're using TCP instead of a Unix socket
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ ^/favicon\.ico { try_files $uri /index.php; }
    location ~ ^/sitemap\.xml { try_files $uri /index.php; }

    location ~ /\.(?!well-known).* { deny all; }

    location ~ ^/media { try_files $uri 404; }

    location ~ ^/themes/.*/assets { try_files $uri 404; }

    error_page 404 /404.html;
    error_page 500 502 503 504 /50x.html;
}
EOF

# Enable the site by creating a symbolic link
echo "Enabling site configuration..."
sudo ln -sf /etc/nginx/sites-available/merarohtak.online.conf /etc/nginx/sites-enabled/

# Test the Nginx configuration for syntax errors
echo "Testing Nginx configuration..."
sudo nginx -t

# Restart Nginx to apply the changes
echo "Restarting Nginx..."
sudo systemctl restart nginx

echo "Nginx configuration updated and service restarted successfully."
