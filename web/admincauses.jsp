<%-- 
    Document   : admincauses
    Created on : Jul 16, 2018, 7:42:59 AM
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
             
              <h3>يمكنك من هنا إضافة اسباب الحجز</h3>
              <a href="admin.jsp" style="position:absolute;top:100px;left:300px;"><h2>العودة للخلف</h2></a>
              <div class="segment">
                 <div>                    
                     
                  <h2>قائمة اسباب الحجز</h2>
                  <br/>
                  <br/>
                   <%
                    try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                   ResultSet r=stm.executeQuery("select * from causes");
                   %>
                    <table border="border" >
                      <tr style="background: #ac2925;">
                          <th>رقم المخالفة</th>
                          <th>المخالفة</th>
                          <th>الغرامة المالية</th>
                                        
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
                      
                     
                  <h2>اضافة اسباب حجز</h2>
                  <br/><br/>
                  <form  method="post">
                      <table cellspacing="20px;"> 
                              <tr><td>
                  <label>المخالفة</label>
                                  </td>
                                  <td>
                   <input type="text"  id="violation" name="violation" placeholder="المخالفة" required>
                                  </td> </tr>
                              
                                      <tr><td>
                  <label>الغرامة المالية</label>
                                  </td>
                                  <td>
                   <input type="text"  id="payment" name="payment" placeholder="الغرامة" required>
                                  </td> </tr>
                                      
                                      
                              <tr><td></td><td>
                  <input type="submit"  value="اضافة مخالفة" name="addviolation" >
                  </td></tr>
                              
                          </table>     
                  </form>
                  <%
                  String viol=request.getParameter("violation");
                   String pay=request.getParameter("payment");
                    if(viol!=null && pay!=null){
                      try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles?useUnicode=true&characterEncoding=utf-8";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                     int n=stm.executeUpdate("insert into causes values(null,'"+viol+"','"+pay+"')");
                   if(n==1) {
                   out.println("تم إضافة مخالفة");
                    response.sendRedirect("admincauses.jsp");
                   }
                 
                   }catch (Exception ex){
                         out.println(ex.getMessage());
                         }//catch
                   
                      }
                  %>
                  </div>   
              </div>
                  
              
              </div> 
              
          </div>
     </body>
</html>
