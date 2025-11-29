Run tests for all modules:
```bash
mvn test
```

Run tests for a specific service:
```bash
cd inventory-service
mvn test
```

## 📦 Packaging

Build all services:
```bash
mvn clean package
```

This will create executable JAR files in each service's `target/` directory.

## 🐳 Docker Support (Future Enhancement)

Docker and Docker Compose configurations can be added for containerization.

## 🤝 Contributing

1. Create a feature branch
2. Make your changes
3. Write/update tests
4. Submit a pull request

## 📄 License

[Specify your license here]

## 👥 Team

Livion Solutions - Sarala ERP Team

## 📞 Support

For support and queries, contact: [your-email@livion.lk]

---

**Package**: `lk.livion.sarala.erp`
**Version**: 1.0.0-SNAPSHOT
# Sarala ERP - Microservices Architecture

A comprehensive Enterprise Resource Planning (ERP) system built with Java 21, Spring Boot 3.2, and microservices architecture in a single repository (monorepo).

## 🏗️ Architecture

This project follows a microservices architecture with the following services:

### Infrastructure Services
- **Service Discovery** (Port 8761) - Eureka Server for service registration and discovery
- **API Gateway** (Port 8080) - Spring Cloud Gateway for routing and load balancing

### Business Services
- **Inventory Service** (Port 8081) - Inventory management
- **Accounts Service** (Port 8082) - Accounting and finance
- **Sales Service** (Port 8083) - Sales management
- **Purchases Service** (Port 8084) - Purchase management
- **HR Payroll Service** (Port 8085) - Human resources and payroll
- **Taxation Service** (Port 8086) - GST/VAT/Tax management
- **Masters Service** (Port 8087) - Master data (Items, Parties, Batches, UOM, etc.)
- **Reports Service** (Port 8088) - Reporting and analytics
- **Settings Service** (Port 8089) - Settings and user management
- **Notifications Service** (Port 8090) - Notifications and messaging
- **Audit Service** (Port 8091) - Audit logging and tracking

### Common Module
Shared utilities, DTOs, entities, and configurations used across all services.

## 🛠️ Technology Stack

- **Java**: 21
- **Spring Boot**: 3.2.0
- **Spring Cloud**: 2023.0.0
- **Database**: PostgreSQL
- **Build Tool**: Maven
- **Service Discovery**: Netflix Eureka
- **API Gateway**: Spring Cloud Gateway
- **Documentation**: SpringDoc OpenAPI (Swagger)
- **Mapping**: MapStruct
- **Utilities**: Lombok

## 📋 Prerequisites

- JDK 21 or later
- Maven 3.8+
- PostgreSQL 14+
- IntelliJ IDEA (recommended) or any Java IDE

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd sarala
```

### 2. Setup Databases

Create the following PostgreSQL databases:

```sql
CREATE DATABASE sarala_inventory;
CREATE DATABASE sarala_accounts;
CREATE DATABASE sarala_sales;
CREATE DATABASE sarala_purchases;
CREATE DATABASE sarala_hr;
CREATE DATABASE sarala_taxation;
CREATE DATABASE sarala_masters;
CREATE DATABASE sarala_reports;
CREATE DATABASE sarala_settings;
CREATE DATABASE sarala_notifications;
CREATE DATABASE sarala_audit;
```

### 3. Build the Project

```bash
mvn clean install
```

### 4. Run Services

Start services in the following order:

#### Start Service Discovery (Eureka Server)
```bash
cd service-discovery
mvn spring-boot:run
```
Access Eureka Dashboard: http://localhost:8761

#### Start API Gateway
```bash
cd api-gateway
mvn spring-boot:run
```

#### Start Business Services
Open separate terminals for each service:

```bash
# Inventory Service
cd inventory-service
mvn spring-boot:run

# Accounts Service
cd accounts-service
mvn spring-boot:run

# Sales Service
cd sales-service
mvn spring-boot:run

# Purchases Service
cd purchases-service
mvn spring-boot:run

# HR Payroll Service
cd hr-payroll-service
mvn spring-boot:run

# Taxation Service
cd taxation-service
mvn spring-boot:run

# Masters Service
cd masters-service
mvn spring-boot:run

# Reports Service
cd reports-service
mvn spring-boot:run

# Settings Service
cd settings-service
mvn spring-boot:run

# Notifications Service
cd notifications-service
mvn spring-boot:run

# Audit Service
cd audit-service
mvn spring-boot:run
```

## 📡 API Endpoints

All services are accessible through the API Gateway at `http://localhost:8080`

- Inventory: `http://localhost:8080/api/inventory/**`
- Accounts: `http://localhost:8080/api/accounts/**`
- Sales: `http://localhost:8080/api/sales/**`
- Purchases: `http://localhost:8080/api/purchases/**`
- HR: `http://localhost:8080/api/hr/**`
- Taxation: `http://localhost:8080/api/taxation/**`
- Masters: `http://localhost:8080/api/masters/**`
- Reports: `http://localhost:8080/api/reports/**`
- Settings: `http://localhost:8080/api/settings/**`
- Notifications: `http://localhost:8080/api/notifications/**`
- Audit: `http://localhost:8080/api/audit/**`

## 📚 API Documentation

Each service has Swagger UI documentation available:

- Inventory: http://localhost:8081/swagger-ui.html
- Accounts: http://localhost:8082/swagger-ui.html
- Sales: http://localhost:8083/swagger-ui.html
- Purchases: http://localhost:8084/swagger-ui.html
- HR: http://localhost:8085/swagger-ui.html
- Taxation: http://localhost:8086/swagger-ui.html
- Masters: http://localhost:8087/swagger-ui.html
- Reports: http://localhost:8088/swagger-ui.html
- Settings: http://localhost:8089/swagger-ui.html
- Notifications: http://localhost:8090/swagger-ui.html
- Audit: http://localhost:8091/swagger-ui.html

## 🏢 Project Structure

```
sarala/
├── common/                      # Shared module
│   └── src/main/java/lk/livion/sarala/erp/common/
│       ├── dto/                 # Common DTOs
│       ├── entity/              # Base entities
│       ├── exception/           # Exception handling
│       └── config/              # Common configurations
├── service-discovery/           # Eureka Server
├── api-gateway/                 # API Gateway
├── inventory-service/           # Inventory management
├── accounts-service/            # Accounting
├── sales-service/               # Sales
├── purchases-service/           # Purchases
├── hr-payroll-service/          # HR & Payroll
├── taxation-service/            # GST/VAT/Tax
├── masters-service/             # Master data
├── reports-service/             # Reports
├── settings-service/            # Settings & Users
├── notifications-service/       # Notifications
├── audit-service/               # Audit logs
└── pom.xml                      # Parent POM
```

## 🔧 Configuration

### Database Configuration
Update database credentials in each service's `application.properties`:
```properties
spring.datasource.username=your_username
spring.datasource.password=your_password
```

### Email Configuration (Notifications Service)
Update email settings in `notifications-service/src/main/resources/application.properties`:
```properties
spring.mail.username=your-email@gmail.com
spring.mail.password=your-app-password
```

### JWT Configuration (Settings Service)
Update JWT secret in `settings-service/src/main/resources/application.properties` for production:
```properties
jwt.secret=your-secure-secret-key
```

## 🧪 Testing


