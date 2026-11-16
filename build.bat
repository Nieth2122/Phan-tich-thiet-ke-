@echo off
REM ============================================================
REM  Bien dich LibMan va copy vao Tomcat
REM  Cach dung:  build.bat "C:\apache-tomcat-10.1.xx"
REM ============================================================
cd /d "%~dp0"

if "%~1"=="" (
    echo Thieu duong dan Tomcat. Vi du: build.bat "C:\apache-tomcat-10.1.34"
    exit /b 1
)
if not exist "%~1\webapps" (
    echo Khong tim thay thu muc webapps trong "%~1"
    exit /b 1
)
if not exist db.properties (
    echo Chua co db.properties: copy db.properties.example thanh db.properties roi sua user/password
    exit /b 1
)
if not exist web\WEB-INF\lib\mssql-jdbc*.jar (
    echo Chua co driver: copy file mssql-jdbc-xxx.jar vao web\WEB-INF\lib
    exit /b 1
)

echo [1/3] Bien dich model va dao...
if exist web\WEB-INF\classes rmdir /s /q web\WEB-INF\classes
javac -encoding UTF-8 -d web\WEB-INF\classes src\model\*.java src\dao\*.java
if errorlevel 1 exit /b 1
copy /y db.properties web\WEB-INF\classes\ >nul

echo [2/3] Copy ung dung vao Tomcat...
if exist "%~1\webapps\LibMan" rmdir /s /q "%~1\webapps\LibMan"
xcopy /e /i /y /q web "%~1\webapps\LibMan" >nul

echo [3/3] Xong. Chay "%~1\bin\startup.bat" roi mo http://localhost:8080/LibMan/
echo       (Neu Tomcat dang chay: chay shutdown.bat roi startup.bat de nap code moi)
