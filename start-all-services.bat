@echo off
echo Starting Sarala ERP Microservices...
echo.

echo Starting Service Discovery (Eureka Server)...
start cmd /k "cd service-discovery && mvn spring-boot:run"
timeout /t 30

echo Starting API Gateway...
start cmd /k "cd api-gateway && mvn spring-boot:run"
timeout /t 15

echo Starting Business Services...
start cmd /k "cd inventory-service && mvn spring-boot:run"
timeout /t 5

start cmd /k "cd accounts-service && mvn spring-boot:run"
timeout /t 5

start cmd /k "cd sales-service && mvn spring-boot:run"
timeout /t 5

start cmd /k "cd purchases-service && mvn spring-boot:run"
timeout /t 5

start cmd /k "cd hr-payroll-service && mvn spring-boot:run"
timeout /t 5

start cmd /k "cd taxation-service && mvn spring-boot:run"
timeout /t 5

start cmd /k "cd masters-service && mvn spring-boot:run"
timeout /t 5

start cmd /k "cd reports-service && mvn spring-boot:run"
timeout /t 5

start cmd /k "cd settings-service && mvn spring-boot:run"
timeout /t 5

start cmd /k "cd notifications-service && mvn spring-boot:run"
timeout /t 5

start cmd /k "cd audit-service && mvn spring-boot:run"

echo.
echo All services are starting...
echo Check Eureka Dashboard at http://localhost:8761
echo API Gateway is at http://localhost:8080
echo.
pause

