<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome Page</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <h1>Hello, this is our project as DevOps Engineers.</h1>
    <div class="form-container">
        <form action="displayText.jsp" method="post">
            <label for="inputText">Text:</label>
            <input type="text" id="inputText" name="inputText">
            <button type="submit">SEND</button>
        </form>
        <div class="link-container">
            <a href="https://github.com/ShayShuve123/DevOps_WebApp" target="_blank">GitHub Repository: DevOps_WebApp</a>
        </div>
    </div>
</body>
</html>