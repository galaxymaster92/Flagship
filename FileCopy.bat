if not exist "C:\Flagship" md "C:\Flagship"
xcopy /y /c /e "%~dp0\*.*" "C:\Flagship"
xcopy /y /c "%~dp0CSC\CSC.lnk" "C:\Users\public\Desktop"
if exist "C:\Users\public\Desktop\CSC.edp" del "C:\Users\public\Desktop\CSC.edp"