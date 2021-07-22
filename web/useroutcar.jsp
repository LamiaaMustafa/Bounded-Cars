<%-- 
    Document   : useroutcar
    Created on : Jul 19, 2018, 6:38:26 AM
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
             
              <h3>يمكنك من هنا اخراج سيارة من مركز الحجز</h3>
              <a href="user.jsp" style="position:absolute;top:100px;left:300px;"><h2>العودة للخلف</h2></a>
              <div class="segment">
                 <div>                    
                     
                  <h2>قائمة السيارات المحجوزة في مركزك</h2>
                  <br/>
                  <br/>
                   <%
                    try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                   ResultSet r=stm.executeQuery("select ca.*,im.in_date,im.region,cs.cause "
                                              + "from impound as im "
                                              + "join cars as ca "
                                              + "on ca.chassis_number=im.car_chassis "
                                              + "join center as c "
                                              + "on c.id=im.center_id "
                                              + "join users as u "
                                              + "on c.id=u.center_id "
                                              + "join impound_cause as ic "
                                              + "on im.id=ic.impound_id "
                                              + "join causes as cs "
                                              + "on cs.id=ic.cause_id "
                                              + "where u.username='"+s+"' and im.id not in(select impound_id from unlock_car)");
                   
                   %>
                    <table border="border" >
                      <tr style="background: #ac2925;">
                          <th>رقم الشاسيه</th>
                          <th>رقم اللوحة</th>
                          <th>الماركة </th>
                          <th>الموديل</th>
                          <th>اللون</th>
                          <th>تاريخ الحجز</th>
                          <th>منطقة الحجز </th>
                          <th>سبب الحجز</th>
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
                      <td><%=r.getString(6) %></td> 
                      <td><%=r.getString(7) %></td>  
                      <td><%=r.getString(8) %></td>  
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
                      
                     
                  <h2> اخراج سيارة من الحجز</h2>
                  
                  <form  method="post">
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
                   ResultSet r=stm.executeQuery("select car_chassis from impound "
                                            + "where center_id=(select center_id from users where username='"+s+"') "
                                            + "and id not in(select impound_id from unlock_car)");
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
                   
                                  </td>  </tr>
                              <tr><td>
                  <input type="submit"  value="احتساب الغرامة" name="calculate" >
                  </td>
                  <%
                      double sum=0.0;
                      double pay2=0.0;
                      double pay1=0.0;
                      String calcstr="";
                      String num=request.getParameter("imcar");
                  if (request.getParameter("calculate") != null) {
                   
                   try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles?useUnicode=true&characterEncoding=utf-8";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                   ResultSet r=stm.executeQuery("SELECT TIMESTAMPDIFF(day,in_date,CURDATE()) from impound "
                           + "where car_chassis='"+num+"'  order by 1 limit 1");
                   if(r.next()){
                   int day=r.getInt(1);
                   pay1=day*500;
                   
                   r=stm.executeQuery("select cs.payments from impound as im "
                                               + "join impound_cause as ic "
                                              + "on im.id=ic.impound_id "
                                              + "join causes as cs "
                                              + "on cs.id=ic.cause_id  where im.car_chassis='"+num+"'");
                   if(r.next()){
                   pay2=r.getInt(1);
                   sum=pay1+pay2;
                   calcstr="المبلغ المترتب على الاقامة:\t\t  "+pay1+"\t\tقيمة المخالفة:\t\t"+pay2+"\t\tالمجموع الكلي\t\t"+ sum;
                   }
                   }     }catch (Exception ex){
                         out.println(ex.getMessage());
                         }//catch
                  }
                  %>
                  <td><label><%=calcstr %></label></td></tr>
                              
                                      <tr><td>
                  <label>المبلغ المدفوع</label>
                                  </td>
                                  <td>
                   <input type="text"  id="payment" name="payment" placeholder="المبلغ" >
                                  </td> </tr>
                                      <tr><td>
                  <label>اسم مسدد المبلغ</label>
                                  </td>
                                  <td>
                   <input type="text"  id="name" name="name" placeholder="الاسم" >
                                  </td> </tr>
                                      <tr><td>
                  <label>الرقم الوطني</label>
                                  </td>
                                  <td>
                   <input type="text"  id="personid" name="personid" placeholder="الرقم الوطني" >
                                  </td> </tr>
                                      
                                      
                              <tr><td></td><td>
                  <input type="submit"  value="اخراج السيارة" name="extract" >
                  </td></tr>
                              
                          </table>     
                  </form>
                  <%
                  String payment=request.getParameter("payment");
                   String name=request.getParameter("name");
                   String personid=request.getParameter("personid");
                   if (request.getParameter("extract") != null) {
                    if(name!=null && personid!=null && payment!=null && num!=null){
                       
                      try{
                    Class.forName("com.mysql.jdbc.Driver");
                   String url="jdbc:mysql://localhost:3306/imbounded_vehicles?useUnicode=true&characterEncoding=utf-8";
                   Connection con=DriverManager.getConnection(url, "root", "");
                   Statement stm= con.createStatement();
                    ResultSet r=stm.executeQuery("select id from impound where car_chassis='"+num+"' and id not in(select impound_id from unlock_car)");
                   out.println(num);
                    if(r.next()){
                        String id=r.getString(1);
                         
                     int n=stm.executeUpdate("insert into unlock_car (impound_id,person_name,person_id,amount) values('"+id+"','"+name+"','"+personid+"','"+payment+"')");
                   if(n==1) {
                   out.println("تم إخراج السيارة");
                    response.sendRedirect("useroutcar.jsp");
                   }
                    }
                   }catch (Exception ex){
                         out.println(ex.getMessage());
                         }//catch
                    }
                      }
                  %>
                  </div>   
              </div>
                  
          </div>
              </div> 
              
         
     </body>
</html>
