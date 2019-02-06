===============================================================
PingFederate Agentless Integration Kit Sample Java Applications 
===============================================================

Release: September, 2012

Copyright (C) 2012 Ping Identity Corporation.  All rights reserved.

This document is provided for informational purposes only, and the information herein is subject to change without notice.  Ping Identity Corporation ("Ping") owns or controls all right, title and license in and to the Ping Agentless Integration Kit, including, but not limited to, all code samples and documentation provided therein (the "AIK").  Ping hereby grants you the limited, revocable, non-transferable, non-sublicensable, worldwide, non-exclusive right to use the AIK for development of software for use in connection with Ping Federate.  Ping is providing the AIK "as is" without warranty of any kind and disclaims any responsibility for any harm resulting from your use of the AIK.

----------
Disclaimer
----------

The purpose of these samples is to demonstrate the use of the Agentless Integration Kit and is not intended as best practices for application development."  and "The sample IdP and SP applications demonstrate both IdP-initiated and SP-initiated SSO to and from your PingFederate server.

The sample IdP and SP applications demonstrate both IdP-initiated and SP-initiated SSO to and from your PingFederate server.  The sample applications do not include IdP-initiated and SP-initiated SLO, Account Linking, and Incoming/Outgoing Attribute Format of Query Parameter and Properties (only JSON).  These will be included in the future and the QuickStart application can be used to demo these features in the meantime.

--------
Overview
--------

This document provides debugging tip and the design description of the sample Java applications bundled with the PingFederate Agentless Integration Kit.

See the Agentless Integration Kit User Guide for information of features, installation, and setup. You can also download the User Guide as a PDF from any page in the online version of the documents. Complete documentation for all PingFederate products is available under Product Documentation at pingidentity.com.


-------------
Debugging Tip
-------------

Single stepping through the sample code using a Java debugger is a good way to understand the application processing.  However, beware that by default the reference value duration is set to 3 seconds, so the reference may expire before it is used.  For debugging only, you may want to temporarily configure the duration longer.  

Certificate Authentication uses the Jetty container SSL facility.  Things can go wrong and the error messages are not necessarily helpful.  A 401 HTTP response indicates that something is wrong.  An error specifying that the client must provide a certificate indicates that the SSL setup is not complete.  

-------------------------------------
Sample Application Design Description
-------------------------------------

This section describes the design details of the sample applications in order to help the developer understand how the Agentless Integration Kit is used.  

The web applications consist of JSP files and can be easily imported into a Java IDE such as Eclipse for viewing and execution monitoring by single-stepping with a Java debugger.  The JSP source can also be viewed using a text editor.

Each application is a simple war folder comprised of JSP files and a Cascading Stylesheet. The JSP files use Java scriptlets to implement functionality in addition to the HTML presentation.  No JavaScript or frameworks are used. Configuration values that may need to change to match PingFederate configuration are defined as constants in the file "configuration.jsp" which is included by the other JSPs.  No build process is needed.  If you wish to customize the sample, modify the deployed JSP files directly and the application server will recompile automatically.

The deployment descriptor defines index.jsp as a welcome file.  The index.jsp file just forwards to the first working JSP.  A simple error.jsp page is used to report errors to the user.  If an exception is caught by the application, a stacktrace is written to System.err and the error.jsp is displayed.

The IdP contains 3 working pages invoked in sequence:

1.) SelectUser.jsp - enables the user to select one of the predefined users.
2.) ConfirmAttributes.jsp - displays the selected users attributes
3.) SubmitToSP.jsp - sends attributes to PingFederate and initiates SSO to SP

The first two pages are used to simulate a real-world IdP.  The third page is where the SSO work is done behind the scene.  SubmitToSP.jsp prepares the user attributes as a JSON object, sends them to the ReferenceID Adapter, and redirects to the PingFederate IdP start SSO application endpoint.  

Sending the attributes is done in the method dropoffAttributesToReferenceIdAdapter(). This method opens a URLConnection to the ReferenceID Adapter, authenticates to the adapter, and then writes the JSON attributes to the connection output stream.  It then waits for the response from which it reads the reference value returned by the adapter.  This reference value is later passed to PingFederate during the SSO redirect and will by used by PingFederate to pickup the attributes during SAML generation.  The reference value is a long String containing hex digits.

The ReferenceID Adapter provides 2 levels of authentication.  The first is username and password which are passed to the ReferenceID Adapter as either cleartext strings in the proprietary request properties (headers) ping.uname and ping.psw respectively, or via the standard HTTP Basic Authentication header as Base64 encoded strings.  The userid and password must match the adapter configuration.

For more secure authentication, the ReferenceID Adapter can be configured to require an SSL certificate by specifying Allowed Subject and/or Issuer DN.  In this case, the Sample application configuration must be modified to point to certificate and key files to be used.  Additional configuration is required -- see the Certificate Authentication Configuration section for the details.

Because by default communication with PingFederate is via HTTPS using self-signed certificates, the sample SubmitToJSP sets the HttpsURLConnection to use a simple X509TrustManager which accepts these certificates.  This technique represents a security vulnerability which must not be used by real applications in production!  

The SP contains two working pages: Login.jsp and ShowAttributes.jsp along with the same supporting files as in the IdP.   ShowAttributes.jsp performs the same steps as SubmitToSP.jsp does in the IdP, but in reverse order.  It gets the reference value from the REF query parameter, uses it to pickup the user attributes, and displays the attributes to the user.  The method pickUpAttributesFromReferenceIdAdapter() connects to the ReferenceID adapter passing the reference value as the REF query parameter.  It then reads the attributes as a JSON object from the adapter response.

The same authentication alternatives are available for the SP to authenticate to the ReferenceID adapter.  Since the SP adapter is different from the IdP adapter, the credentials and even the authentication method may be different.   

For SP initiated SSO, the SP application provides the Login.jsp page which renders a Login button that invokes the IdP to login when pressed.  Thereafter the process is the same as IdP-initiated SSO.

The sample can easily be modified by a developer to implement custom behavior.  Simply modify the appropriate JSP in the WAR directory and redeploy.  No build is necessary since the application server will pick up the changes.  

