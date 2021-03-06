<%--************************************************************
* Copyright (C) 2012 Ping Identity Corporation                 *
* All rights reserved.                                         *
*                                                              *
* The contents of this file are subject to the terms of the    *
* PingFederate Agentless Integration Kit Users Guide.          *
************************************************************--%>

<%--
Define constants corresponding to PingFederate configuration.

This file is intended to be included by another JSP via <%@ include file="configuration.jsp" %>.  
See SelectUser.jsp for example.
--%>

<%@ page import="java.util.*" %><%--Needed for USERS HashMap. --%>

<%!
// PingFederate URLs and endpoints
private final static String PF_BASE_URL = "https://localhost";
private final static String PF_PRIMARY_SSL_PORT = "9031";
private final static String PF_SECONDARY_SSL_PORT = "9032"; // Must match PF setting.
private final static String PF_START_SSO_ENDPOINT = "/idp/startSSO.ping"; 

// ReferenceID Adapter configuration
private final static String  REFID_DROPOFF_URL = "/ext/ref/dropoff";
private final static String  REFID_INSTANCE_ID = "idpadapter";
private final static String  REFID_USERNAME = "idpuser";
private final static String  REFID_PASSWORD = "idppassword";
private final static boolean REFID_USE_BASIC_HTTP_AUTH = true;  // If false, use proprietary ping.uname and ping.pwd headers
private final static boolean CERTIFICATE_AUTHENTICATION = true;
private final static String  CLIENT_KEY_FILE_PATH = "/FULL/PATH/TO/CERTIFICATES/sampleClientSSLCert.p12"; // Full pathname for PKCS12 (.p12) key file.
private final static String  CLIENT_KEY_FILE_PASSWORD = "password";
private final static String  SERVER_CERTIFICATE_PATH = "/FULL/PATH/TO/CERTIFICATES/pfserverSSLCert.crt";  // Full pathname to X.509 Server SSL cert file.
private final static boolean SKIP_HOSTNAME_VERIFICATION = true;

// Connection configuration
private final static String PARTNER_ENTITY_ID = "PF-DEMO";

// List of defined users.  Key is user subject, value is a Map of user attributes.
private final static Map<String,Map<String,String>> USERS = 
	new HashMap<String,Map<String,String>>()
	{{
		put("john",  new HashMap<String,String>(){{ put("name", "John Brown"); put("status", "Silver"); }});
	  	put("peter", new HashMap<String,String>(){{ put("name", "Peter Tester"); put("status", "Bronze"); }});
	  	put("mary",  new HashMap<String,String>(){{ put("name", "Mary White"); put("status", "Gold"); }});
	}};
%>