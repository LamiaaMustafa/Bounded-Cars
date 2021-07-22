<%-- 
    Document   : administitution
    Created on : Jul 19, 2018, 6:04:40 AM
    Author     : Syla-Group
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
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
              <br/><h1> مرحبا <%=s %></h1>
             
              <h3>يمكنك من هنا إضافة او حذف حسابات المؤسسات الحكومية </h3>
              <a href="admin.jsp" style="position:absolute;top:100px;left:300px;"><h2>العودة للخلف</h2></a>
              <div class="segment">
                 <div>                    
                     
                  <h2>قائمة المؤسسات</h2>
                  <br/>
                  <br/>
                   <%
                    try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                   ResultSet r=stm.executeQuery("select * from government_institutions");
                   %>
                    <table border="border" >
                      <tr style="background: #ac2925;">
                          <th>رمز المؤسسة</th>
                          <th>اسم المؤسسة</th>
                          <th>كلمة المرور</th>
                                        
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
                      
                     
                  <h2>اضافة حساب لمؤسسة حكومية</h2>
                  <br/><br/>
                  <form  method="post">
                      <table cellspacing="20px;"> 
                              <tr><td>
                  <label>رمز المؤسسة</label>
                                  </td>
                                  <td>
                   <input type="text"  id="username" name="username" placeholder="رمز المؤسسة" required>
                                  </td> </tr>
                              
                                      <tr><td>
                  <label>اسم المؤسسة</label>
                                  </td>
                                  <td>
                   <input type="text"  id="name" name="name" placeholder="اسم المؤسسة" required>
                                  </td> </tr>
                                       <tr><td>
                  <label>كلمة المرور</label>
                                  </td>
                                  <td>
                   <input type="text"  id="password" name="password" placeholder="كلمة المرور" required>
                                  </td> </tr>
                                      
                                      
                              <tr><td></td><td>
                  <input type="submit"  value="اضافة " name="add" >
                  </td></tr>
                              
                          </table>     
                  </form>
                  <%
                  String username=request.getParameter("username");
                   String name=request.getParameter("name");
                   String password=request.getParameter("password");
                    if(username!=null && name!=null && password!=null){
                      try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles?useUnicode=true&characterEncoding=utf-8";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                     int n=stm.executeUpdate("insert into government_institutions values('"+username+"','"+name+"','"+password+"')");
                   if(n==1) {
                   out.println("تم إضافةحساب لمؤسسة حكومية جديدة");
                   response.sendRedirect("administitution.jsp");
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
                      
                     
                  <h2>حذف حساب مؤسسة</h2>
                  
                  <form   method="post">
                      <table cellspacing="20px;"> 
                              
                                      <tr><td>
                  <label>رمز المؤسسة</label>
                                  </td>
                                   <%
                                  try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                   ResultSet r=stm.executeQuery("select username from government_institutions");
                   %>
                                  <td>
                   <select  id="instdelete" name="instdelete" required>
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
                  
                   <input type="submit"  value="حذف " name="delete" >
                  </td></tr>
                                                           
                          </table>     
                  </form>
                   <%
                    String del=request.getParameter("instdelete");
                    try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                   int n=stm.executeUpdate("delete from government_institutions where username='"+del+"'");
                   
                   if(n==1){
                   out.println("تم حذف حساب المؤسسة");
                   response.sendRedirect("administitution.jsp");
                   }
                   }catch (Exception ex){
                         out.println(ex.getMessage());
                         }//catch

                  %>
                  </div>   
              </div>
         
              
              </div> 
              
          </div>
     </body>
</html>

