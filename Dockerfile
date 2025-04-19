# Use an official Python runtime as a parent image
FROM python:3.10

# Set the working directory in the container
WORKDIR /app

# Copy the project files into the container
COPY . /app/

# Install dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Explicitly install Gunicorn
RUN pip install gunicorn

# Expose the port Django runs on
EXPOSE 8000

# Start the Django application using Gunicorn
CMD ["sh", "-c", "python manage.py migrate && python manage.py collectstatic --noinput && python create_superuser.py && gunicorn --bind 0.0.0.0:8000 onlinejobportal.wsgi:application"]


