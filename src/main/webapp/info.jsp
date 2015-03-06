<%@page import="pt.ist.parkingInfo.Config"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.InputStream"%>
<%
    final InputStream is = new URL(Config.CAR_PARK_INFO_GET_URL).openStream();
    try {
        final BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
        final StringBuilder sb = new StringBuilder();
        int cp;
        while ((cp = rd.read()) != -1) {
            sb.append((char) cp);
        }
%>
<%= sb.toString() %>
<%
    } finally {
        is.close();
    }
%>
