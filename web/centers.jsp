<%-- 
    Document   : centers
    Created on : Jul 14, 2018, 8:36:31 AM
    Author     : Syla-Group
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title>impounde centers</title>

    
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
                                      <p>المراكز</p>
                                    </div> <!-- end of date box -->
                                    
                                    <div class="post_body">
                                           
                                           <h2>مراكز الحجز</h2>
                                           <br/>
                                           <br/>
                                                                             
                                            <div class="post_content">
                                              <p> 
                                            </p>
                                            <%
                                             try{
                                             Class.forName("com.mysql.jdbc.Driver");
                                            String url="jdbc:mysql://localhost:3306/imbounded_vehicles";
                                            Connection con=DriverManager.getConnection(url, "root", "");
                                            Statement stm= con.createStatement();
                                            ResultSet r=stm.executeQuery("select * from center");
                                            %>
                                             <table border="black">
                                               <tr style="background: #ac2925;">
                                                    <th>مركز الحجز</th>
                                                     <th>العنوان</th>
                                                     
                                               </tr>
                                           <%
                                            while(r.next()){
                                           %>
                                           <tr>
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
                                            <li><a href="searchaction.jsp">للاستعلام عن سيارتك</a></li>
                                            <li><a href="#">مراكز الحجز</a></li>
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
