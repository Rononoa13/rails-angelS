# README

# 📚 Ruby on Rails API - User & Content Management System

A simple RESTful API built with Ruby on Rails that provides:

- User authentication (Signup / Signin)

- JWT-based authorization

- Content creation and management

- Ownership-based access control

---

# 🚀 Tech Stack

- Ruby on Rails (API mode)

- PostgreSQL

- JWT Authentication

- RSpec (testing)

- Postman (API testing)

---

# 📦 Features

## 👤 User

- Signup user

- Signin user

- JWT token generation on login

## 📝 Content

- Create content (authenticated users only)

- View all own contents

- Update own content only

- Delete own content only

---

# 🛠️ Setup Instructions

## 1. Clone the repository

## 2. Install dependencies

- bundle install

## 3. Setup database

- rails db:create

- rails db:migrate

## 4. Start the server

- rails s

## 5. Postman Collection

- https://awtestteam.postman.co/workspace/AWtest~0fac1783-b47e-45c4-90f5-be404c076fc6/collection/11568389-811e5f4f-708d-4f03-9b31-7fcf8127eb67?action=share&source=copy-link&creator=11568389


## 🐳 Containerization (Docker Setup)

- This project is fully containerized using Docker and Docker Compose. It allows the application to run without installing Ruby, PostgreSQL, or any dependencies locally.

🚀 Run the Application with Docker

- docker compose up

Access the Application

- http://localhost:3000

Manually Run the migration in another terminal with following command
  - `docker compose exec web rails db:create`
  - `docker compose exec web rails db:migrate`

# TODOs

- Unit Test for Content Controller

- Deployment
