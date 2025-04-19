import os
import django
from django.contrib.auth import get_user_model

# Setup Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'onlinejobportal.settings')
django.setup()

# Create a superuser only if it does not exist
User = get_user_model()
if not User.objects.filter(username="admin").exists():
    User.objects.create_superuser("admin", "admin@gmail.com", "admin")
    print("Superuser created successfully!")
else:
    print("Superuser already exists.")
