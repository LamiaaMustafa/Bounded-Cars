<%-- 
    Document   : admin
    Created on : Jul 14, 2018, 11:10:08 PM
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
        <title>admin</title>
      <link href="mystyle.css" rel="stylesheet">
      <style>
          input[type=submit]{
    width:300px;
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
                      <div style="padding:20px ;">
                          <table cellspacing="20px" > 
                                
                              <tr>
                                  <td><input type="submit"  value="ادارة المستخدمين" name="user" ></td>
                                  <td> <input type="submit"  value="ادارة المراكز" name="center" ></td>
                              </tr>
                              
                              
                                  <tr>
                                  <td> <input type="submit"  value="أسباب الحجز" name="causes" ></td>
                                  <td><input type="submit"  value="التقارير" name="reports" ></td>
                                  </tr>
                                   <tr>
                                  <td> <input type="submit"  value="المؤسسات الحكومية" name="istitution" ></td>
                                  <td><input type="submit"  value="تسجيل خروج" name="logout"></td>
                                  </tr>

                          </table> 
                      </div>
                  </form>
                  
                  <%
                   Enumeration e=request.getParameterNames();
                    String sub="";
                    while(e.hasMoreElements())
                    sub=(String)e.nextElement();
                    if(sub.equals("user")){
                                response.sendRedirect("adminuser.jsp");
                    }else if(sub.equals("center")){
                        
                                response.sendRedirect("admincenter.jsp");
                    }else if(sub.equals("causes")){
                                response.sendRedirect("admincauses.jsp");
                    }else if(sub.equals("reports")){
                                response.sendRedirect("reports.jsp");
                    }else if(sub.equals("istitution")){
                                response.sendRedirect("administitution.jsp");
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