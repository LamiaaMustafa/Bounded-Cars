<%-- 
    Document   : adminuser
    Created on : Jul 16, 2018, 7:45:16 AM
    Author     : Syla-Group
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
              <h3>يمكنك من هنا إضافة أو حذف المستخدمين </h3>
              <a href="admin.jsp" style="position:absolute;top:80px;left:300px;"><h2>العودة للخلف</h2></a>
              <div class="segment">
                 <div>                    
                     
                  <h2>قائمة المستخدمين</h2>
                  <br/><br/>

                   <%
                    try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                   ResultSet r=stm.executeQuery("select * from view_user");
                   %>
                    <table border="border" >
                      <tr style="background: #ac2925;">
                          <th>اسم المستخدم</th>
                          <th>كلمة المرور</th>
                          <th>اسم الموظف</th>
                          <th>الرقم الوطني</th>
                          <th>مركز الحجز</th>                         
                      </tr>
                  <%
                   while(r.next()){
                  %>
                  <tr>
                      <td><%=r.getString(1) %></td>  
                      <td><%=r.getString(2) %></td> 
                      <td><%=r.getString(3) %></td>  
                      <td><%=r.getString(4) %></td>  
                      <td><%=r.getString(5) %></td>  
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
                      
                     
                  <h2>اضافة المستخدمين</h2>
                  
                  <form  method="post">
                      <table cellspacing="15px;"> 
                              <tr><td>
                  <label>اسم المستخدم</label>
                                  </td>
                                  <td>
                   <input type="text"  id="username" name="username" placeholder="اسم المستخدم" required>
                                  </td> </tr>
                              
                              <tr><td>
                  <label>كلمة المرور</label>
                                  </td>
                                  <td>
                     <input type="password"  id="password" name="password" placeholder="كلمة المرور" required>
                                  </td></tr>
                                      <tr><td>
                  <label>اسم الموظف</label>
                                  </td>
                                  <td>
                   <input type="text"  id="empname" name="empname" placeholder="اسم الموظف" required>
                                  </td> </tr>
                                      <tr><td>
                  <label>الرقم الوظني</label>
                                  </td>
                                  <td>
                   <input type="text"  id="empid" name="empid" placeholder="الرقم الوظني" required>
                                  </td> </tr>
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
                   <select  id="center" name="center" required>
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
                                  </td> </tr>
                              <tr><td></td><td>
                  <input type="submit"  value="اضافة مستخدم" name="adduser" id="adduser">
                  </td></tr>
                              
                          </table>     
                  </form>
                  <%
                  String username=request.getParameter("username");
                   String pw=request.getParameter("password");
                    String empname=request.getParameter("empname");
                     String empid=request.getParameter("empid");
                      String centername=request.getParameter("center");
                      
                      if(username!=null && pw!=null && empname!=null && empid!=null && centername!=null){
                      try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                     ResultSet r=stm.executeQuery("select id from center where name='"+centername+"'");
                   if(r.next()){
                  int centerid=r.getInt(1);
                  int n=stm.executeUpdate("insert into users values('"+username+"','"+pw+"','"+empname+"','"+empid+"','"+centerid+"')");
                 if(n==1){
                   out.println("تم إضافة مستخدم");
                   response.sendRedirect("adminuser.jsp");
                   }else{
                   
                   }
                 
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
                      
                     
                  <h2>حذف المستخدمين</h2>
                  
                  <form   method="post">
                      <table cellspacing="20px;"> 
                              
                                      <tr><td>
                  <label>اسم المستخدم</label>
                                  </td>
                                  <%
                                  try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                   ResultSet r=stm.executeQuery("select username from users");
                   %>
                                  <td>
                   <select  id="userdelete" name="userdelete" required>
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
                                  </td> </tr>
                              <tr><td></td><td>
                  
                   <input type="submit"  value="حذف مستخدم" name="deleteuser" id="deleteuser">
                  </td></tr>
                                                           
                          </table>     
                  </form>
                   <%
                    String del=request.getParameter("userdelete");
                    out.println("<br/>");
                   
                        try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                   int n=stm.executeUpdate("delete from users where username='"+del+"'");
                   
                   if(n==1){
                   out.println("تم حذف المستخدم");
                   response.sendRedirect("adminuser.jsp");
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
