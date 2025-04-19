#!/bin/bash

echo "🚀 Starting the Django project with Docker..."

# Step 1: Build and start containers
docker-compose up --build -d

# Step 2: Wait for the database to initialize
echo "⏳ Waiting for the database to be ready..."
sleep 5

# Step 3: Run migrations inside the running container
echo "⚙️ Running migrations..."
docker-compose exec -T web python manage.py migrate

# Step 4: Collect static files (if needed)
echo "📁 Collecting static files..."
docker-compose exec -T web python manage.py collectstatic --noinput

# Step 5: Create superuser
echo "👤 Creating Django superuser..."
docker-compose exec -T web python create_superuser.py

# Step 6: Open the app in a browser
echo "🌍 Opening the web application..."
if which xdg-open > /dev/null; then
    xdg-open http://localhost:8000
elif which open > /dev/null; then
    open http://localhost:8000
else
    echo "❗ Unable to open browser. Please open http://localhost:8000 manually."
fi

echo "✅ Setup complete! Your app is running at http://localhost:8000"
