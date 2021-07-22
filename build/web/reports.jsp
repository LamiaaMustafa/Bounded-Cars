<%-- 
    Document   : reports
    Created on : Jul 14, 2018, 4:18:30 PM
    Author     : Syla-Group
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
           
    <link href="mystyle.css" rel="stylesheet">
    
  </head>
    <body>

                  <div id="content_wrapper">
          <div id="content">
               <%
        String s=(String)session.getAttribute("userid");
        if(s==null){
        response.sendRedirect("login.html");
        }
           %>
              <h1> مرحبا <%=s %></h1>
             <h3>يمكنك من هنا طباعة التقارير </h3>
              <a href="index.jsp" style="position:absolute;top:80px;left:300px;"><h2>العودة للصفحة الرئيسية</h2></a>
               <div class="segment">
                  
                  <div>                    
                     
                  <h2>تحديد الفترة الزمنية المطلوب دراستها</h2>
                  <br/><br/>
                  <form  method="post" action="pdfreports.jsp">
                      <table cellspacing="15px;"> 
                              <tr><td>
                  <label>تاريخ البداية</label>
                                  </td>
                                  <td>
                   <input type="date"  id="startdate" name="startdate" placeholder="" required>
                                  </td> </tr>
                              
                                      <tr><td>
                  <label>تاريخ النهاية</label>
                                  </td>
                                  <td>
                   <input type="date"  id="enddate" name="enddate" placeholder="" required>
                                  </td> </tr>
                                      
                                      
                              <tr><td></td><td>
                  <input type="submit"  value="انشاء تقرير" name="report" >
                  </td></tr>
                              
                          </table>     
                  </form>
                  
                  </div>   
              </div>
                   
              </div> 
              
          </div>
      </div>
          </body>
</html>
