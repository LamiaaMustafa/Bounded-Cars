<%-- 
    Document   : admincenter
    Created on : Jul 16, 2018, 7:44:50 AM
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
             <h3>يمكنك من هنا إضافة أو حذف المراكز </h3>
              <a href="admin.jsp" style="position:absolute;top:80px;left:300px;"><h2>العودة للخلف</h2></a>
              <div class="segment">
                 <div>                    
                     
                  <h2>قائمة المراكز</h2>
                  
                   <%
                    try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                   ResultSet r=stm.executeQuery("select * from center");
                   %>
                    <table border="border" >
                      <tr style="background: #ac2925;">
                          <th>رقم المركز</th>
                          <th>اسم المركز</th>
                          <th>العنوان</th>
                                        
                      </tr>
                  <%
                   while(r.next()){
                  %>
                  <tr>
                      <td><%=r.getString(1) %></td>  
                      <td><%=r.getString(2) %></td> 
                      <td><%=r.getString(3) %></td>  
                      
                  </tr>
                  <%
                  }//while

                 out.println("</table>");

                   r.close();
                   }catch (Exception ex){
                   out.println(ex.getMessage());
                   }//catch
                    %>   
                  </div>
                  </div>   
              <div class="segment">
                  
                  <div>
                      
                     
                  <h2>اضافة المراكز</h2>
                  <br/><br/>
                  <form  method="post">
                      <table cellspacing="15px;"> 
                              <tr><td>
                  <label>اسم المركز</label>
                                  </td>
                                  <td>
                   <input type="text"  id="name" name="name" placeholder="اسم المركز" required>
                                  </td> </tr>
                              
                                      <tr><td>
                  <label>العنوان</label>
                                  </td>
                                  <td>
                   <input type="text"  id="address" name="address" placeholder="العنوان" required>
                                  </td> </tr>
                                      
                                      
                              <tr><td></td><td>
                  <input type="submit"  value="اضافة مركز" name="addcenter" >
                  </td></tr>
                              
                          </table>     
                  </form>
                  <%
                  String name=request.getParameter("name");
                   String address=request.getParameter("address");
                    if(name!=null && address!=null){
                      try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles?useUnicode=true&characterEncoding=utf-8";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                     int n=stm.executeUpdate("insert into center values(null,'"+name+"','"+address+"')");
                   if(n==1) {
                   out.println("تم إضافة مركز");
                    response.sendRedirect("admincenter.jsp");
                   }
                 
                   }catch (Exception ex){
                         out.println(ex.getMessage());
                         }//catch
                   
                      }
                  %>
                  </div>   
              </div>
                   <div class="segment1">
                  
                  <div>
                      
                     
                  <h2>حذف مركز</h2>
                  
                  <form   method="post">
                      <table cellspacing="20px;"> 
                              
                                      <tr><td>
                  <label>اسم المركز</label>
                                  </td>
                                   <%
                                  try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                   ResultSet r=stm.executeQuery("select name from center");
                   %>
                                  <td>
                   <select  id="centerdelete" name="centerdelete" required>
                       <% while(r.next()){
                        %>
                        <option><%=r.getString(1) %></option>
                        <%
                        }
                         r.close();
                         }catch (Exception ex){
                         out.println(ex.getMessage());
                         }//catch
                        %>
                   </select>
                   </select>
                                  </td> </tr>
                              <tr><td></td><td>
                  
                   <input type="submit"  value="حذف مركز" name="delete" >
                  </td></tr>
                                                           
                          </table>     
                  </form>
                   <%
                    String del=request.getParameter("centerdelete");
                    try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                   int n=stm.executeUpdate("delete from center where name='"+del+"'");
                   
                   if(n==1){
                   out.println("تم حذف المركز");
                   response.sendRedirect("admincenter.jsp");
                   }
                   }catch (Exception ex){
                         out.println(ex.getMessage());
                         }//catch

                  %>
                  </div>   
              </div>
         
              
              </div> 
              
          </div>
      </div>
          </body>
</html>
