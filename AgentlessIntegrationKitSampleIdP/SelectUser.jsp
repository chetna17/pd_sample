<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%--************************************************************
* Copyright (C) 2012 Ping Identity Corporation                 *
* All rights reserved.                                         *
*                                                              *
* The contents of this file are subject to the terms of the    *
* PingFederate Agentless Integration Kit Users Guide.          *
************************************************************--%>

<%--
	This page is part of the Agentless Integration Kit Sample which demonstrates the use of the kit. 

	The IdP Application pages are:
	  > 1 - SelectUser.jsp  <- this page
		2 - ConfirmAttributes.jsp
		3 - SubmitToSP.jsp 

	This IdP Application page lets the user select a user from a list and submits to the ConfirmAttributes page.
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
	<title>PingFederate Agentless Integration Kit Sample : IdP</title>
	<link href="css/stylesheet.css" rel="stylesheet" type="text/css" />
</head>
<%@ include file="configuration.jsp" %>
<body>
  <div class="width">
    <div class="header">
  		PingFederate Agentless Integration Kit Sample<br/>
		<div class="idp">Identity Provider</div>
	</div>
    <div class="mainbody">
	    <h1>Step 1 : User Authentication</h1>
			<div class="info">
                This is the Identity Provider (IdP) application that is responsible for identifying and authenticating the user. 
				A "real world" application would require the user to login using some form of authentication (e.g.: username and password).<br/><br/>
				For the purpose of this sample, simply select a user from the dropdown list and click the Login button.
                The resulting user attributes will be read from local configuration.
			</div>

        <form action="ConfirmAttributes.jsp" method="post">
            Select User:
            <select name="user">
			<% for(String username:USERS.keySet()) { %>
                <option><%=username%></option> 
			<% } %>
			</select>
			<input class="submitButton" type="submit" value="Login" name="Login" />
        </form>
	</div>
  </div>
</body>
</html>