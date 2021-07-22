<%-- 
    Document   : user
    Created on : Jul 14, 2018, 3:24:18 PM
    Author     : Syla-Group
--%>

<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
        
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
      <link href="mystyle.css" rel="stylesheet">
      <style>
          input[type=submit]{
    width:400px;
    height: 50px;
    background-color: #ac2925;
    font-size: 24px;
    font-weight: bold;
}
          
      </style>
    
  </head>                                      
  <body>
      
                  <div id="content_wrapper">
          <div id="content">
              <br/><br/><br/><br/>
              <div class="segment">
                  
                  <div>
                      <%
        String s=(String)session.getAttribute("userid");
        if(s==null){
        response.sendRedirect("login.html");
        }
           %>
                  <h2>مرحبا<%=s %> </h2>
                 
                  <form  method="post">
                      
                          <table cellspacing="20px" align="center" > 
                                
                              <tr><td><input type="submit"  value="ادخال سيارة" name="incar" ></td></tr>
                              <tr><td> <input type="submit"  value="اخراج سيارة" name="outcar" ></td></tr>
                               <tr><td><input type="submit"  value="تسجيل خروج" name="logout"></td>
                                  </tr>
                              
                             </table> 
                      
                  </form>
                  
                  <%
                   Enumeration e=request.getParameterNames();
                    String sub="";
                    while(e.hasMoreElements())
                    sub=(String)e.nextElement();
                    if(sub.equals("incar")){
                                response.sendRedirect("userincar.jsp");
                    }else if(sub.equals("outcar")){                        
                                response.sendRedirect("useroutcar.jsp");                
                    }else if(sub.equals("logout")){
                                response.sendRedirect("index.html");
                                session.setAttribute("username", null);
                         }
                    
                    
                  %>
                  </div>   
              </div> 
              
          </div>
      </div>
      
  </body>           