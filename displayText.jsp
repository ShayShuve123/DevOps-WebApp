<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Display Text</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <h1>This is your text. Thank you for your cooperation.</h1>
    <div class="text-box">
        <p><%= request.getParameter("inputText") %></p>
    </div>
    <p>Have a nice day!</p>
</body>
</html>