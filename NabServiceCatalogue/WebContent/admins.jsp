<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">

        <title>Dashboard</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <!-- Our Custom CSS -->
        <link rel="stylesheet" href="./style5.css">
        <script type="text/javascript">
        
        $(document).ready(function(){
        	$('#register').hide();
        	$('#createtask').hide();
        	$('#signup').click(function(){
        		$('#register').show();
        		$('#createtask').hide();
        	})
        	$('#task').click(function(){
        		$('#createtask').show();
        		$('#register').hide();
        	})
        	
        })
        </script>
        
    </head>
    <body>
<nav class="navbar navbar-default">
  <div class="container-fluid" align="right">
    <ul class="nav navbar-nav">

      <li><a href="#">Welcome Vipin</a></li>
      <li><a href="#">Logout</a></li>
      
    </ul>
  </div>
</nav>


        <div class="wrapper">
            <!-- Sidebar Holder -->
            <nav id="sidebar">
                <div class="sidebar-header">
                    <h3>Admin</h3>
                </div>

                <ul class="list-unstyled components">
                   
                    <li class="active">
                        <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false">Through Put</a>
                        <ul class="collapse list-unstyled" id="homeSubmenu">
                            <li><a href="./intchart.jsp">Monthly</a></li>
                            <li><a href="#">Users</a></li>
                        </ul>
                    </li>
                    <li>
                       
                        <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false">Tasks</a>
                        <ul class="collapse list-unstyled" id="pageSubmenu">
                            <li><a href="#" id=signup>Create User</a></li>
                            <li><a href="#" id=task >Create Task</a></li>
                            <li><a href="#">Update User</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">Portfolio</a>
                    </li>
                    <li>
                        
                    </li>
                </ul>
            </nav>

            <!-- Page Content Holder -->
            <div id="content">

                

            </div>
            
           
			 			<div class="panel-body">
			    		<form role="form" id=register>
			    			<div class="row">
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			                <input type="text" name="username" id="usernamee" size=60 class="form-control input-sm" placeholder="UserName">
			    					</div>
			    				</div>
			    			</div>
							<div class="row">
							<div class="col-xs-6 col-sm-6 col-md-6">
			    			<div class="form-group ">
			    				<input type="email" name="email" id="email" class="form-control input-sm" placeholder="Email Address">
			    			</div>
							</div></div>
			    			<div class="row">
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			    						<input type="password" name="password" id="password" class="form-control input-sm" placeholder="Password">
			    					</div>
			    				</div>
			    				
			    			</div>
			    		<input type="submit" value="Register" size=60 	class=" btn btn-info btn-block">
			    		</form>
			    		
			    	</div>
			    	<div class="panel-body">
			    		<form role="form" id=createtask>
			    			<div class="row">
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			                <input type="text" name="username" id="usernamee" size=60 class="form-control input-sm" placeholder="HL Task">
			    					</div>
			    				</div>
			    			</div>
							<div class="row">
							<div class="col-xs-6 col-sm-6 col-md-6">
			    			<div class="form-group ">
			    				<input type="email" name="email" id="email" class="form-control input-sm" placeholder="Low level Task">
			    			</div>
							</div></div>
			    			<div class="row">
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			    						<input type="password" name="password" id="password" class="form-control input-sm" placeholder="Point">
			    					</div>
			    				</div>
			    				
			    			</div>
			    		<input type="submit" value="Create task" size=60 	class=" btn btn-info btn-block">
			    		</form>
			    		
			    	</div>
	    		</div>
    		</div>
        </div>





        <!-- jQuery CDN -->
         <script src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
         <!-- Bootstrap Js CDN -->
         <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

         <script type="text/javascript">
             $(document).ready(function () {
                 $('#sidebarCollapse').on('click', function () {
                     $('#sidebar').toggleClass('active');
                     $(this).toggleClass('active');
                 });
             });
         </script>
    </body>
</html>

</body>
</html>