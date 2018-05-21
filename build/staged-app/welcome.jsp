<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@  page  import="com.timer.Contact" %> 
    <%response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0);
String profilepicurl="";
if(session.getAttribute("user") == null)
	response.sendRedirect("/index.jsp");
else
{
Contact sessionuser=(Contact)session.getAttribute("user");
if(sessionuser.getProfileurl() == null)
   profilepicurl="person-dummy.jpg";
else
	profilepicurl=sessionuser.getProfileurl();
}
%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService,com.google.appengine.api.blobstore.UploadOptions.Builder,com.google.appengine.api.blobstore.UploadOptions"%>

<%
    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
UploadOptions uploadOptions=Builder.withGoogleStorageBucketName("timerrestapi.appspot.com");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
     <title>Home</title>
      
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
     <link rel="stylesheet" href="dashboard.css">
</head>
<body> 

<!--modals -->

  
<div id="profiledetailsmodal" class="modal" role="dialog">
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-body">
				<div id="imagediv">
				  <img alt="User Photo" src="<%=profilepicurl%>" width="120px" height="120px" class="img-circle">   
				   <a  href="" id="profilepics">change photo</a>   
			 <form style="display:none" action="<%= blobstoreService.createUploadUrl("/imageupload",uploadOptions)%>" method="post" enctype="multipart/form-data">
                       <input type="file" name="profilepic" id="imageupload">
			 </form>
				</div>
				<button style="margin-left: 500px" type="button" id="edit"
						class="btn btn-sm editclassB">
						<span class="glyphicon glyphicon-pencil editclassB"></span> Edit
					</button>
       <table class="table table-striped"> 
       <thead>
          <p class="updatenotification" id="error" style="display:none;margin-left:100px;font-size:15px">
      </p>
      <p class="updatenotification" id="nochanges" style="display:none;margin-left:100px;font-size:15px">
      No changes to Modify
      </p>
      <p class="updatenotification" id="updated" style="display:none;margin-left:100px;font-size:15px">
      Profile Updated Successfully
      </p>
       </thead>
       <tbody>
       <tr>
       <td>Name</td>
        <td class="sessiondata" id="sessionname">${sessionScope.user.name}</td>
        <td class="data" style="display:none"><input type="text" value="${sessionScope.user.name}" name="name" id="name" required></td>
        </tr>
       <tr>
       <td>Email</td>
        <td class="sessiondata" id="sessionemail">${sessionScope.user.email}</td>
        <td class="data" style="display:none"><input type="email" value="${sessionScope.user.email}" name="email" id="email" disabled readonly></td>
        </tr>  
      <tr>
      <td>Mobile Number</td>
        <td class="sessiondata" id="sessionphoneno">${sessionScope.user.mobileNumber}</td>
        <td class="data" style="display:none"><input type="tel" pattern="[789][0-9]{9}" title="Please Enter valid Mobile number" value="${sessionScope.user.mobileNumber}" name="mobileNumber" id="mobileNumber"></td>
        </tr>
        <tr>
        <td> Address</td>
        <td class="sessiondata" id="sessionadress">${sessionScope.user.address}</td>
         <td class="data" style="display:none"><input type="text" value="${sessionScope.user.address}" name="address" id="address"></td>
        </tr> 
        
        <tr> 
        
         <td class="data"><input type="hidden" value="${sessionScope.user.id}" id="userid"></td>
        </tr>   
              
     </tbody>
        </table>
					
				</div>
				<div class="modal-footer">
					
					<button type="button" data-toggle="modal"
						data-target="#confirmDelete"
						class="btn btn-danger btn-sm editclassB">
						<span class="glyphicon glyphicon-trash editclassB"></span> Close Account
					</button>
					<button type="button"  class="btn buttons updateback" id="updatebtn" style="display:none" >UPDATE</button>
				    <button type="button"  class="btn buttons updateback" id="close" style="display:none">BACK</button>
				</div>
			</div>
		</div>
	</div>
	<div id="confirmDelete" class="modal" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-body">
					<p>Confirm account deletion.</p>
				</div>
				<div class="modal-footer">
					<a href="/user/delete"><button type="button" class="btn btn-default" id="deactivate">YES</button></a>
					<button type="button" class="btn" data-dismiss="modal">No</button>
				</div>
			</div>
		</div>
	</div>
	<%-- <div id="uploadimage" class="modal" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-body">
					    <form action="<%= blobstoreService.createUploadUrl("/imageupload",uploadOptions)%>" method="post" enctype="multipart/form-data">
                       <input type="file" name="profilepic">
                        <br>
                      <input type="submit" value="upload"> 
                   </form>
					<div class="modal-footer">
						<button type="button" class="btn" data-dismiss="modal">Cancel</button>
					</div>

				</div>
			</div>
		</div>
	</div> --%>


<!--  main content  -->
<div class="top">
     
     <p class="top-elements">
     <span id="welcomename">${sessionScope.user.name}</span> 
          
  <img src="<%=profilepicurl%>" alt="User Photo" class=" img-circle profilepic" id="profilepic">
     
  </p>   
      <div  class="menus text-center" id="menus">

      <button  
        class="btn btn-default dropdown" data-toggle="modal" 
			data-target="#profiledetailsmodal">My profile</button>  
       
         <button id="logout" class="btn btn-default dropdown">Logout</button>
        </div>
 </div>
  
  
 <div class="row ">
        <div class="col-lg-4 height" style="background-color:lightcyan" id="entrylist">
             <div class="timeinfo" id="timeinfo">
                 <div class="date"><span id="date"></span></div>     
                 <div><span id="intime" class="timeslist"></span> <span id="outtime" class="timeslist"></span> <span id="hours" class="timeslist"></span></div>
             </div>
         </div>
       <div class="col-lg-8 height" style="background-color:lightgray;">
            <div class="timer">
                <div class="time" >
                  <span id="lblhr">00</span>
                  : <span  id="lblmin">00</span>
                  : <span  id="lblsec">00</span></div> 
               <br><br>
               <br>
               <button type="button" class="btn btn-default" id="clockin">Clock In</button>
               
               <button type="button" class="btn btn-default" id="clockout">Clock Out</button>
                <br>
               <input type="hidden" id="entry">
               
            </div>
         </div>
</div>
    
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src=".//js/dashboard.js"></script> 
  <script src=".//js/timer.js"></script> 
</body>
</html>