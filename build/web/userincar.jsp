<%-- 
    Document   : userincar
    Created on : Jul 19, 2018, 6:37:38 AM
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
             
              <h3>يمكنك من هنا ادخال سيارة الى مركز الحجز</h3>
              <a href="user.jsp" style="position:absolute;top:100px;left:300px;"><h2>العودة للخلف</h2></a>
              
              <div class="segment">
                  
                  <div>
                      
                     
                  <h2>ادخال بيانات السيارة</h2>
                  <br/>
                  <form  method="post">
                      <table cellspacing="15px;"> 
                              <tr><td>
                  <label>رقم الشاسيه</label>
                                  </td>
                                  <td>
                   <input type="text"  id="chassis" name="chassis" placeholder="رقم الشاسيه" required>
                                  </td> </tr>
                              
                                      <tr><td>
                  <label>رقم اللوحة</label>
                                  </td>
                                  <td>
                   <input type="text"  id="plate" name="plate" placeholder="رقم اللوحة" required>
                                  </td> </tr>
                                      <tr><td>
                                      <label>الماركة</label>
                                  </td>
                                  <td>
                   <input type="text"  id="maker" name="maker" placeholder="الماركة" required>
                                  </td> </tr>
                                      <tr><td>
               <label>الموديل</label>
                                  </td>
                                  <td>
                   <input type="text"  id="model" name="model" placeholder="الموديل" >
                                  </td> </tr>
                                      <tr><td>
               <label>اللون</label>
                                  </td>
                                  <td>
                   <input type="text"  id="color" name="color" placeholder="اللون" required>
                                  </td> </tr>
                                      
                                      
                              <tr><td></td><td>
                  <input type="submit"  value="اضافة " name="add" >
                  </td></tr>
                              
                          </table>     
                  </form>
                  <%
                  String chassis=request.getParameter("chassis");
                   String plate=request.getParameter("plate");
                   String maker=request.getParameter("maker");
                   String model=request.getParameter("model");
                   String color=request.getParameter("color");
                   String msg=null;
                    if(chassis!=null && plate!=null && maker!=null && color!=null){
                      try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles?useUnicode=true&characterEncoding=utf-8";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                     int n=stm.executeUpdate("insert into cars values('"+chassis+"','"+plate+"','"+maker+"','"+model+"','"+color+"')");
                   if(n==1) {
                   out.println("تم إضافة سيارة");
                   
                   }
                 
                   }catch (Exception ex){
                       msg=ex.getMessage();
                       if(msg.equals("Duplicate entry '"+chassis+"' for key 'PRIMARY'")){
                       out.println("يبدو أن السيارة مسجلة لدينا");
                       }else{
                         out.println(ex.getMessage());
                       }
                         }//catch
                   
                      }
                  %>
                  </div>   
              </div>
                <div class="segment">
                  
                  <div>
                      
                     
                  <h2>حجز سيارة</h2>
                  
                  <form   method="post">
                      <table cellspacing="20px;"> 
                              
                                      <tr><td>
                  <label>رقم الشاسيه</label>
                                  </td>
                                   <%
                                  try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                   ResultSet r=stm.executeQuery("select chassis_number from cars");
                   %>
                                  <td>
                   <select  id="imcar" name="imcar" required>
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
                        <tr><td>
                                      <label>المنطقة</label>
                                  </td>
                                  <td>
                   <input type="text"  id="region" name="region" placeholder="المنطقة" required>
                                  </td> </tr>
                        <tr><td>
                  <label>سبب الحجز</label>
                                  </td>
                                   <%
                                  try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                   ResultSet r=stm.executeQuery("select cause from causes");
                   %>
                                  <td>
                   <select  id="imcause" name="imcause" required>
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
                  
                   <input type="submit"  value="حجز السيارة" name="delete" >
                  </td></tr>
                                                           
                          </table>     
                  </form>
                   <%
                    String imcause=request.getParameter("imcause");
                    String region=request.getParameter("region");
                    String imcar=request.getParameter("imcar");
                     if(imcar!=null && region!=null && imcause!=null){
                    try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                    ResultSet r=stm.executeQuery("select center_id from users where username='"+s+"'");
                    String cen_id="";
                    if(r.next()){
                    cen_id=r.getString(1);
                    }
                   int n=stm.executeUpdate("insert into impound (car_chassis,center_id,region) values('"+imcar+"','"+cen_id+"','"+region+"')");
                   r=stm.executeQuery("select id from impound where car_chassis='"+imcar+"' order by in_date desc");
                   if(r.next()){
                   String im_id=r.getString(1);
                    r=stm.executeQuery("select id from causes where cause='"+imcause+"'");
                    if(r.next()){
                     String cause_id=r.getString(1);
                   stm.executeUpdate("insert into impound_cause values('"+im_id+"','"+cause_id+"')");
                   }
                   }
                   if(n==1){
                   out.println("تم حجز السيارة");
                   
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
