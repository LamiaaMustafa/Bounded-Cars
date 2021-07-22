<%-- 
    Document   : pdfreports
    Created on : Jul 19, 2018, 9:27:47 PM
    Author     : Syla-Group
--%>

<%@page import="java.io.FileOutputStream"%>
<%@page import="com.itextpdf.text.pdf.PdfWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="application/PDF; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
    </head>
    <body>
        <h1>تقرير عن حركة السيارات في مراكز الحجز</h1>
        <%
     try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                   ResultSet r=stm.executeQuery("select COUNT(*) from impound");
                   r.first();
                   String count=r.getString(1);
    
    r.close();
                   }catch (Exception ex){
                   out.println(ex.getMessage());
                   }
%>
    </body>
</html>
