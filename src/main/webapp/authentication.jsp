<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
 
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Sign In Page</title>
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<!-- Custom CSS -->
	<style>
		body {
			background: linear-gradient(0.25turn, #3f87a6, #ebf8e1, #f69d3c);
 
		}
 
		.banner {
			background: linear-gradient(0.25turn, #3f87a6, #ebf8e1, #f69d3c);
			display: flex;
			justify-content: space-around;
			align-items: center;
			width: 100%;
			font-size: 1.8rem;
		}
 
		.containerr {
			height: 3rem;
			background: linear-gradient(#e66465, #9198e5);
			display: flex;
			justify-content: flex-end;
			align-items: center;
		}
 
		.signin-container {
			max-width: 400px;
			margin: 0 auto;
			padding: 20px;
			background-color: #ffffff;
			border-radius: 8px;
			box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
			margin-top: 50px;
		}
 
		.signin-heading {
			text-align: center;
			margin-bottom: 20px;
		}
 
		.form-group {
			margin-bottom: 20px;
		}
 
		.form-label {
			font-weight: bold;
		}
 
		.btn-login {
			background-color: #007bff;
			color: #fff;
		}
 
		.btn-login:hover {
			background-color: #0056b3;
		}
 
		.alert {
			margin-top: 20px;
		}
 
		.hidden {
			display: none;
		}
		 .form-check-input {
        border-color: black; /* You can adjust the value as needed */
    }
	</style>
	 <script>
        $(document).ready(function () {
            // Initially hide the specific fields
            $('#adminFields, #teacherFields, #govtEmployeeFields, #nonGovtEmployeeFields').addClass('hidden');

            // Initialize login credentials object
            var loginCredentials = {
                loginAs: $('#loginAs').val().trim(),
                username: '',
                password: '',
                treasuryid: '',
                mobilenumberteacher: ''
            };

            $('#loginAs').change(function () {
                var selectedValue = $(this).val();

                // Hide all fields initially
                $('#adminFields, #teacherFields, #govtEmployeeFields, #nonGovtEmployeeFields').addClass('hidden');

                // Update login credentials based on selected value
                loginCredentials.loginAs = selectedValue;
                if (loginCredentials.loginAs === 'admin') {
                    $('#adminFields').removeClass('hidden');
                } else if (loginCredentials.loginAs === 'teacher') {
                    $('#teacherFields').removeClass('hidden');
                }
            });

            $('#loginForm').submit(function (event) {
                event.preventDefault();

                // Update login credentials with form values
                if (loginCredentials.loginAs === 'admin') {
                    loginCredentials.username = $('#username').val().trim();
                    loginCredentials.password = $('#passwordId').val().trim();
                } else if (loginCredentials.loginAs === 'teacher') {
                    loginCredentials.treasuryid = $('#treasuryId').val().trim();
                    loginCredentials.mobilenumberteacher = $('#mobileNumber').val().trim();
                }

                // Determine the API URL based on the role
                var apiUrl = '';
                if (loginCredentials.loginAs === 'admin') {
                    apiUrl = '/api/admin/login';
                } else if (loginCredentials.loginAs === 'teacher') {
                    var isGovtEmployee = $('input[name="govtEmployee"]:checked').val() === 'yes';

                    if (isGovtEmployee) {
                        apiUrl = '/api/teacher/login';
                    } else {
                        apiUrl = '/api/teacher/cfmsid';

                        // Add parameters for non-govt employee
                        var cfmsId = $('#cfmsId').val().trim();
                        var mobileNumberNonGovt = $('#mobileNumberNonGovt').val().trim();
                        apiUrl += '?cfms_id=' + cfmsId + '&mobileno_teacher=' + mobileNumberNonGovt;

                        // AJAX Request for non-govt employee
                        $.ajax({
                            url: apiUrl,
                            type: 'GET',
                            success: function (response) {
                                console.log('Non-Govt Employee Login successful');
                                setCFMSIdSession();
                                window.location.href='/mainFrameTrainee.jsp';
                                // Handle success for non-govt employee login

                                // Now, you can handle the response as needed
                                // For example, you might want to update the UI or take other actions.
                            },
                            error: function (xhr, status, error) {
                                console.error('Non-Govt Employee Login failed', error);
                                // Handle error for non-govt employee login
                            }
                        });

                        // Reset the API URL for the main login request
                        apiUrl = '/api/teacher/login';
                    }
                }

                // AJAX Request for the main login (for govt employees or teachers)
                $.ajax({
                    url: apiUrl,
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(loginCredentials),
                    success: function (response) {
                        console.log('Login successful');

                        // Determine the dashboard based on the role
                        var dashboardUrl = '';
                        if (loginCredentials.loginAs === 'admin') {
                            dashboardUrl = '/MainFrameAdmin.jsp';
                        } else if (loginCredentials.loginAs === 'teacher') {
                            dashboardUrl = '/mainFrameTrainee.jsp';
                        }

                        showAlert('Login Successful', 'alert-success');
                        // Redirect to the appropriate dashboard
                        window.location.href = dashboardUrl;
                    },
                    error: function (xhr, status, error) {
                        console.error('Login failed', error);
                        showAlert('Login Failed. Please check your credentials. Error: ' + error, 'alert-danger');
                    }
                });
            });
            // Handle radio button change event
            $('input[name="govtEmployee"]').change(function () {
                var isGovtEmployee = $('input[name="govtEmployee"]:checked').val() === 'yes';

                if (isGovtEmployee) {
                    // Show govt employee fields
                    $('#govtEmployeeFields').removeClass('hidden');
                    $('#nonGovtEmployeeFields').addClass('hidden');
                } else {
                    // Show non-govt employee fields
                    $('#govtEmployeeFields').addClass('hidden');
                    $('#nonGovtEmployeeFields').removeClass('hidden');
                }
            });

            function showAlert(message, alertClass) {
                var alertDiv = $('<div class="alert ' + alertClass + ' mt-3" role="alert">' + message + '</div>');
                $('#loginForm').prepend(alertDiv);
                setTimeout(function () {
                    alertDiv.alert('close');
                }, 3000);
            }
        });
    </script>
<body>
	<div>
		<div>
			<div class="banner">
				<div>
					<img src="./assets/logo1Transparent.png" alt="Second logo">
				</div>
				<diV>
					<p>Teacher Training Support System <br>Government Of Andhra Pradesh</p>
				</diV>
				<div>
					<img src="./assets/logo2Tranparenet.png" alt="First Logo">
				</div>
			</div>
		</div>
		<div class="containerr">
			<!--<div class="container2">
                <p><a href="authentication.html">Login</a></p>
            </div> -->
		</div>
		</div>
		<div class="container">
			<div class="signin-container">
				<h2 class="signin-heading">Login</h2>
				<form action="" method="post" id="loginForm">
					<div class="form-group">
						<label for="loginAs" class="form-label">Login As</label>
						<select class="form-select" id="loginAs" name="loginAs">
							<option value="admin">----Select Role----</option>
							<option value="admin">Admin</option>
							<option value="teacher">Teacher</option>
						</select>
					</div>
 
				<!-- Admin Fields -->
					<div id="adminFields" class="form-group hidden">
						<label for="username" class="form-label">Username</label>
						<input type="text" class="form-control" id="username" name="username" />
						<label for="password" class="form-label">Password</label>
						<input type="password" class="form-control" id="passwordId" name="password" />
						<button type="submit" class="btn btn-primary btn-login btn-block onclick="setTreasuryIdSession()">Log In</button>
					</div>
 
					

<!-- Teacher Fields -->
<div id="teacherFields" class="form-group hidden">
<!--     <label for="treasuryId" class="form-label">Treasury Id</label> -->
<!--     <input type="text" class="form-control" id="treasuryId" name="treasuryId" /> -->

<!--     <label for="mobileNumber" class="form-label">Mobile Number</label> -->
<!--     <input type="text" class="form-control" id="mobileNumber" name="mobileNumber" /> -->

    <label class="form-label">Are you a government employee?</label>

    <div class="form-check">
        <input class="form-check-input" type="radio" name="govtEmployee" id="govtEmployeeYes" value="yes">
        <label class="form-check-label" for="govtEmployeeYes">Yes</label>
    </div>

    <div class="form-check">
        <input class="form-check-input" type="radio" name="govtEmployee" id="govtEmployeeNo" value="no" >
        <label class="form-check-label" for="govtEmployeeNo">No</label>
    </div>

    <!-- Additional Fields for Govt Employee -->
    <div id="govtEmployeeFields" class="hidden">
        <!-- Add the fields you want to display for govt employees here -->
        <!-- For example: -->
         <label for="treasuryId" class="form-label">Treasury Id</label>
    <input type="text" class="form-control" id="treasuryId" name="treasuryId" />

    <label for="mobileNumber" class="form-label">Mobile Number</label>
    <input type="text" class="form-control" id="mobileNumber" name="mobileNumber" />
        <!-- Add more fields as needed -->
    </div>

    <!-- Additional Fields for Non-Govt Employee -->
    <div id="nonGovtEmployeeFields" class="hidden">
        <label for="cfmsId" class="form-label">CFMS ID</label>
        <input type="text" class="form-control" id="cfmsId" name="cfmsId" />

        <label for="mobileNumberNonGovt" class="form-label">Mobile Number</label>
        <input type="text" class="form-control" id="mobileNumberNonGovt" name="mobileNumberNonGovt" />
    </div>

    <button type="submit" class="btn btn-primary btn-login btn-block" onclick="setTreasuryIdSession()" >Log In</button>
</div>

 <!-- <script> 
    // Initially hide all fields
     $('#govtEmployeeFields, #nonGovtEmployeeFields').addClass('hidden'); 

     // Handle radio button change event 
    $('input[name="govtEmployee"]').change(function () { 
         var isGovtEmployee = $('input[name="govtEmployee"]:checked').val() === 'yes'; 

         if (isGovtEmployee) { 
            // Show govt employee fields 
             $('#govtEmployeeFields').removeClass('hidden'); 
            $('#nonGovtEmployeeFields').addClass('hidden'); 
         } else { 
            // Show non-govt employee fields 
             $('#govtEmployeeFields').addClass('hidden'); 
            $('#nonGovtEmployeeFields').removeClass('hidden'); 
         } 
     }); 
 </script> --> 

<!-- ... (Rest of the HTML code) ... -->

				<!--  	<div class="form-group form-check">
						<input type="checkbox" class="form-check-input" id="rememberMe" />
						<label class="form-check-label" for="rememberMe">Remember me</label>
					</div> -->
		 
				</form>
			</div>
		</div>
		<script>
			function setTreasuryIdSession() {
				var treasuryId = document.getElementById('treasuryId').value;
 
				if (typeof (Storage) !== "undefined") {
					sessionStorage.setItem("treasuryId", treasuryId);
 
				} else {
					alert("Sorry, your browser does not support session storage.");
				}
			}
		</script>
		<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
 <script>
    function setCFMSIdSession() {
        // Get the current value of CFMS ID
        var cfmsId = document.getElementById('cfmsId').value;
        console.log(cfmsId);

        // Check if the browser supports session storage
        if (typeof (Storage) !== "undefined") {
            // Set the CFMS ID in session storage
            sessionStorage.setItem("cfmsId", cfmsId);
        } else {
            // Display an alert if session storage is not supported
            alert("Sorry, your browser does not support session storage.");
        }
    }
</script>


 
 
 
		<!-- Bootstrap JS (optional, only needed if you use Bootstrap JavaScript components) -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
 
</html>
