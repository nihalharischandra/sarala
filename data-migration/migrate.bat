@echo off
echo ========================================
echo BUSY to Sarala Migration Utility
echo ========================================
echo.

:menu
echo Please select an option:
echo.
echo 1. Test Database Connections
echo 2. View Migration Statistics
echo 3. Migrate Item Masters Only
echo 4. Migrate Party Masters Only
echo 5. Full Migration (All Masters)
echo 6. Export BUSY Data to CSV
echo 7. Exit
echo.
set /p choice=Enter your choice (1-7):

if "%choice%"=="1" goto test_connection
if "%choice%"=="2" goto view_stats
if "%choice%"=="3" goto migrate_items
if "%choice%"=="4" goto migrate_parties
if "%choice%"=="5" goto full_migration
if "%choice%"=="6" goto export_csv
if "%choice%"=="7" goto exit

echo Invalid choice. Please try again.
goto menu

:test_connection
echo.
echo Testing database connections...
curl -X GET http://localhost:8092/api/migration/health
echo.
pause
goto menu

:view_stats
echo.
echo Fetching migration statistics...
curl -X GET http://localhost:8092/api/migration/stats
echo.
pause
goto menu

:migrate_items
echo.
echo WARNING: This will migrate all Item Masters from BUSY to Sarala.
set /p confirm=Continue? (Y/N):
if /i "%confirm%"=="Y" (
    echo Migrating items...
    curl -X POST http://localhost:8092/api/migration/execute-items
    echo.
    echo Migration completed!
)
pause
goto menu

:migrate_parties
echo.
echo WARNING: This will migrate all Party Masters from BUSY to Sarala.
set /p confirm=Continue? (Y/N):
if /i "%confirm%"=="Y" (
    echo Migrating parties...
    curl -X POST http://localhost:8092/api/migration/execute-parties
    echo.
    echo Migration completed!
)
pause
goto menu

:full_migration
echo.
echo ========================================
echo FULL MIGRATION WARNING
echo ========================================
echo This will migrate ALL master data from BUSY to Sarala:
echo - Unit of Measurements
echo - Item Groups
echo - Party Groups
echo - Item Masters
echo - Party Masters
echo - And more...
echo.
echo Make sure you have:
echo 1. Backed up your Sarala database
echo 2. Verified connection settings
echo 3. Tested with sample data first
echo.
set /p confirm=Are you absolutely sure? (YES/NO):
if /i "%confirm%"=="YES" (
    echo.
    echo Starting full migration...
    echo Please wait, this may take several minutes...
    curl -X POST http://localhost:8092/api/migration/execute
    echo.
    echo.
    echo ========================================
    echo Migration completed!
    echo ========================================
    echo Check migration.log for detailed results
)
pause
goto menu

:export_csv
echo.
echo Exporting BUSY data to CSV files...
echo (This feature requires SQL Server access)
echo.
echo Please run the queries in migration-queries.sql manually
echo and save results as CSV files.
echo.
pause
goto menu

:exit
echo.
echo Thank you for using BUSY to Sarala Migration Utility
exit

