<%-- 
    Document   : searchaction
    Created on : Jul 13, 2018, 7:23:11 AM
    Author     : Syla-Group
--%>


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   
    <title>search car</title>

    

    <link href="mystyle.css" rel="stylesheet">
    
  </head>
  <body>
      <div id="top_panel_wrapper">
          <div id="top_panel">
                <div id="_menu">
          
          <div  class="mymenu">
          <ul>
          <li><a href="index.html">الرئيسية</a></li>
          <li><a href="login.html">تسجيل دخول</a></li>
          <li><a href="about.html" >عن موقعنا</a></li>
          <li><a href="institution.html">مؤسسة حكومية</a></li>
          <li><a href="contact.html">تواصل</a></li>
          </ul>
          
          </div>
          
                  </div>
                  
                  <div id="banner">
                  
                    <div id="site_title">
                          <h1> الإدارة العامة لحجز المركبات</h1>
                </div>
                      
                  </div> <!-- end of banner -->
              
              </div> <!-- end of top_panel -->
              
         
          </div> <!-- end of  top_panel_wrapper -->
          <div id="content_wrapper">
              <div id="content">
                  
                     <div id="main_content_top"></div>
                     <div id="main_coontent">
                      
                        <div id="main_column">
                          <div class="post_box">
                            <div class="date_box">
                                      <p>بحث</p>
                                    </div> <!-- end of date box -->
                                    
                                    <div class="post_body">
                                           
                                           <h2>يمكنك الاستعلام عن سيارتك </h2>
                                           <br/>
                                           <br/>
                                                <br/><br/>                             
                                            <div class="post_content">
                                              <form  method="post">
                          <table > 
                              <tr><td>
                  <label>رقم الشاسيه</label>
                                  </td><td>&nbsp;&nbsp;&nbsp;</td><td>
                   <input type="text"  id="chassis" name="chassis" placeholder="رقم الشاسيه" required>
                                  </td> </tr>
                              <tr>
                                  <td><br/></td>
                              </tr>
                              <tr><td>
                  <label>رقم اللوحة</label>
                                  </td><td>&nbsp;&nbsp;&nbsp;</td><td>
                     <input type="text"  id="plate" name="plate" placeholder="رقم اللوحة" required>
                                  </td></tr><tr>
                                  <td><br/></td>
                              </tr><tr>
                                  <td><br/></td>
                              </tr>
                              <tr><td></td><td></td><td>
                  <input type="submit"  value="بحث" name="search" id="search">&nbsp;&nbsp;
                  <input type="submit"  value="حجوزات سابقة" name="history" id="history">
                                  </td></tr>
                              
                          </table>    
                                                
                                                </div>
                                    
                                  </div> <!-- end of post body -->
                                                
                                </div> <!-- end of a post -->
                                <div class="post_box">
                            <div class="date_box">
                                <p>النتائج</p>
                                    </div> <!-- end of date box -->
                                    
                                    <div class="post_body">
                                           
                                           <div class="post_content">
                                            
                                               <br/>
                                               <%
                                               String chassis= request.getParameter("chassis");
                                               String plate= request.getParameter("plate");
                                              if(chassis!=null && plate!=null){
                                                      Enumeration e=request.getParameterNames();
                                        String s="";
                                        while(e.hasMoreElements())
                                           s=(String)e.nextElement();
                                        //connecting db
                                            Class.forName("com.mysql.jdbc.Driver");
                                            String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                                        if(s.equals("search")){
                                        
                                            try{
                                            Connection con=DriverManager.getConnection(url, "root", "");
                                            Statement stm= con.createStatement();
                                            ResultSet r=stm.executeQuery("select * from view_search_car where chassis_number='"+chassis+"' and plate_number='"+plate+"'");
                                           if(r.next()){
                                           %>
                                           <p>السيارة ذات المواصفات التالية:</p>
                                           <table cellspacing="20px;">
                                               <tr>
                                                   <td>رقم الشاسيه</td>
                                                   <td><%=r.getString(1) %></td>
                                               </tr> 
                                               <tr>
                                                   <td>رقم اللوحة</td>
                                                   <td><%=r.getString(2) %></td>
                                               </tr>
                                               <tr>
                                                   <td>الصانع</td>
                                                   <td><%=r.getString(3) %></td>
                                               </tr> 
                                               <tr>
                                                   <td>الموديل</td>
                                                   <td><%=r.getString(4) %></td>
                                               </tr>
                                               <tr>
                                                   <td>اللون</td>
                                                   <td><%=r.getString(5) %></td>
                                               </tr> 
                                               </table>
                                               <p>تم حجزها بتاريخ : <br/><%=r.getString(8) %></p>
                                               <p>و هي حاليا موجودة في مركز حجز :<br/><%=r.getString(6) %></p>
                                               <p>العنوان :<br/><%=r.getString(7) %></p>
                                               <p>لمزيد من المعلومات يرجى مراجعة المركز المذكور...</p>
                                           <%                                          
                                          
                                            }//if
                                            else{
                                             out.println("سيارتك ليست محجوزة في مراكزنا");   
                                            }
                                            r.close();
                                            }catch (Exception ex){
                                            out.println(ex.getMessage());
                                            }//catch
                                            
                                        }else{try{
                                            Connection con=DriverManager.getConnection(url, "root", "");
                                            Statement stm= con.createStatement();
                                            ResultSet r=stm.executeQuery("select * from impound_history where car_chassis='"+chassis+"'");
                                           %>
                                           <p>حركة السيارة من و الى مراكز الحجز:</p>
                                           <br/>
                                           <table border="black">
                                               <tr style="background: #ac2925;">
                                                    <th>مركز الحجز</th>
                                                     <th>تاريخ الحجز</th>
                                                      <th>تاريخ الفك</th>
                                                       <th>المبلغ المدفوع</th>
                                               </tr>
                                           <%
                                            while(r.next()){
                                           %>
                                           <tr>
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
                                         }//else
                                        }//if               
                                             %>  
                                            </div>
                                    
                                   </div> <!-- end of post body -->
                                                
                                </div> <!-- end of a post -->
                            </div> <!-- end of main column -->
                            <div id="side_column">

                               <div class="side_column_section">
                                    
                                      
                                        <ul class="side_menu">
                                            <li><a href="about.html">حول الشركة</a></li>
                                            <li><a href="aims.html">أهداف الشركة</a></li>
                                            <li><a href="services.html">خدمات الشركة</a></li>
                                            <li><a href="causes.html">أسباب الحجز</a></li>
                                             <li><a href="#">للاستعلام عن سيارتك</a></li>
                                            <li><a href="centers.jsp">مراكز الحجز</a></li>
                                            <li><a href="contact.html"> للتواصل</a></li>
                                                 
                                        </ul>
                                    
                                    </div>
                        
                                   </div> <!-- end of side column -->
                                   <div class="cleaner"></div> 
                                  </div> <!-- end of main content -->
                                  <div id="main_content_bottom"></div>
                                
                                </div> <!-- content -->
                            
                            </div> <!-- end of content_wrapper -->
                            <div id="footer_wrapper">

                                <div id="footer">
                                  
                                    
                                      <div class="section_w200">
                                      
                                        <h4>الادارة العامة لحجز المركبات</h4>
                                          
                                          <p>سوريا - دمشق - شارع السلام</p>
                                          
                                    </div>
                                      
                                      <div class="section_w200">
                                      
                                        <h4>للاستفسار</h4>
                                          
                                        <p> Tel: 8877661 | Fax: 8877662 <br/>
                                           <a href="mailto:imbounded@gmail.com">Email:imbounded@gmail.com</a></p>
                                          
                                                                              
                                      </div>
                                      
                                     
                                      
                                    <div class="cleaner"></div>
                                  </div> <!-- end of footer -->
                              
                            <div class="cleaner"></div>
                          </div> <!-- end of footer_wrapper -->
              
 
</body>
</html>