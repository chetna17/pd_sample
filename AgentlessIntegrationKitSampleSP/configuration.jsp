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
See ShowAttributes.jsp for example.
--%>

<%!
//PingFederate URLs and endpoints
private final static String PF_BASE_URL = "https://localhost";
private final static String PF_PRIMARY_SSL_PORT = "9031";
private final static String PF_SECONDARY_SSL_PORT = "9032"; // Must match PF setting.
private final static String PF_START_SSO_ENDPOINT="/sp/startSSO.ping"; 

// ReferenceID Adapter configuration
private final static String REFID_PICKUP_URL = "/ext/ref/pickup";
private final static String REFID_INSTANCE_ID = "spadapter";
private final static String REFID_USERNAME = "spuser";
private final static String REFID_PASSWORD = "sppassword";
private final static boolean REFID_USE_BASIC_HTTP_AUTH = true;  // If false, use proprietary ping.uname and ping.pwd headers
private final static boolean CERTIFICATE_AUTHENTICATION = true;
private final static String  CLIENT_KEY_FILE_PATH = "/FULL/PATH/TO/CERTIFICATES/sampleClientSSLCert.p12"; // Full pathname for PKCS12 (.p12) key file.
private final static String  CLIENT_KEY_FILE_PASSWORD = "password";
private final static String  SERVER_CERTIFICATE_PATH = "/FULL/PATH/TO/CERTIFICATES/pfserverSSLCert.crt";  // Full pathname to X.509 Server SSL cert file.
private final static boolean SKIP_HOSTNAME_VERIFICATION = true;

// Connection configuration
private final static String PARTNER_ENTITY_ID = "PF-DEMO";
%>
