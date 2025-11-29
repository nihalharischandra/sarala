@echo off
echo Starting BUSY to Sarala Migration Service...
echo.

REM Check if Java is installed
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Java is not installed or not in PATH
    echo Please install Java 21 or later
    pause
    exit /b 1
)

REM Check if Maven is installed
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Maven is not installed or not in PATH
    echo Please install Maven 3.8 or later
    pause
    exit /b 1
)

echo Building migration service...
call mvn clean package -DskipTests

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Build failed
    pause
    exit /b 1
)

echo.
echo Starting migration service on port 8092...
echo.
echo Access the service at: http://localhost:8092
echo API endpoints:
echo   - POST http://localhost:8092/api/migration/execute   (Full migration)
echo   - GET  http://localhost:8092/api/migration/stats     (Statistics)
echo   - GET  http://localhost:8092/api/migration/health    (Health check)
echo.
echo Press Ctrl+C to stop the service
echo.

java -jar target\data-migration-1.0.0-SNAPSHOT.jar

pause

