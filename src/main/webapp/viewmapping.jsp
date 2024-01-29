<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>TTSS</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
        integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
        crossorigin="anonymous">
    <!-- Toastr CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
    <!-- DataTables CSS -->
    <!-- DataTables Buttons CSS -->
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- DataTables JS -->
   
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- Toastr JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
    <!-- xlsx.full.min.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.3/xlsx.full.min.js"></script>
    <!-- Custom Styles -->
    <link href="css/styles.css" rel="stylesheet" />
    <style>
        .serial-column {
            font-weight: bold;
        }

        .table thead th {
            background-color: #007bff;
            color: #fff;
            font-weight: bold;
            border-color: #007bff;
        }

        .table tbody td {
            border-color: #007bff;
        }

        .table tbody tr:hover {
            background-color: #f1f1f1;
        }

        .btn {
            font-size: 14px;
        }

        .edit-button {
            width: 62.47px;
        }

        .button-width-100 {
            width: 80px;
        }
    </style>

</head>
<body>
 
	<a href="/mastermapping2.jsp" class="btn btn-success mt-2" style="background-color: #5cb85c; border-color: #5cb85c;">Create
		New Mapping +</a>
	<div class="card mt-2" style="width: 100%;">
		<div class="card-body">
			<div class="table-responsive">
				<table class="table table-bordered table-striped" id="trainingTable" style="font-size: 14px;">
					<!-- Table headers go here -->
					<thead>
						<tr>
							<th>Sl no</th>
							<th>Training Ref Id</th>
							<th>Training Name</th>
							<th>Venue Id</th>
							<th>Venue Name</th>
							<th>Co-ordinator Flag</th>
							<th>Co-ordinator TreasuryId</th>
							<th>Co-ordinator Name</th>
							<th>Co-ordinator Designation</th>
							<th>Co-ordinator Email</th>
							<th>Co-ordinator Mobile</th>
							<th>Co-ordinator District</th>
							<th>Co-ordinator Mandal</th>
							<th>Asst. Co-ordinator Flag</th>
							<th>Asst. Co-ordinator TreasuryId</th>
							<th>Asst. Co-ordinator Name</th>
							<th>Asst. Co-ordinator Designation</th>
							<th>Asst. Co-ordinator Email</th>
							<th>Asst. Co-ordinator Mobile</th>
							<th>Asst. Co-ordinator District</th>
							<th>Asst. Co-ordinator Mandal</th>
							<th>Trainer Flag</th>
							<th>Trainer TreasuryId</th>
							<th>Trainer Name</th>
							<th>Trainer Designation</th>
							<th>Trainer Email</th>
							<th>Trainer Mobile</th>
							<th>Trainer District</th>
							<th>Trainer Mandal</th>
							<th>Office-staffs Flag</th>
							<th>Office-staffs  TreasuryId</th>
							<th>Office-staffs  Name</th>
							<th>Office-staffs  Designation</th>
							<th>Office-staffs  Email</th>
							<th>Office-staffs  Mobile</th>
							<th>Office-staffs  District</th>
							<th>Office-staffs  Mandal</th>
							<th>Participants Flag</th>
							<th>Participants TreasuryId</th>
							<th>Participants Name</th>
							<th>Participants Designation</th>
							<th>Participants Email</th>
							<th>Participants Mobile</th>
							<th>Participants District</th>
							<th>Participants Mandal</th>
							<th>Status</th>
							<th>Action</th>
							
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
	</div>
	<script>
			// Execute the function on page load
			fetchDataAndDisplay();
			function fetchDataAndDisplay() {
				$.ajax({
					type : "GET",
					url : "/api/mapped/trainings",
					dataType : "json",
					success : function(data) {
						displayTrainingData(data);
					},
					error : function(xhr, status, error) {
						console.error("API request error: " + error);
						toastr.error("Failed to fetch training data");
					}
				});
			}
			function displayTrainingData(data) {
				var trainings = data;
				trainings.reverse();
				var tableBody = $("#trainingTable tbody");
				// Clear existing rows
				tableBody.empty();
				for (var i = 0; i < trainings.length; i++) {
					var training = trainings[i];
					var row = $("<tr></tr>");
	                row.append("<td class='serial-column'>" + (i + 1) + "</td>");
	                row.append("<td style='display: none;'>" + training.slno + "</td>");
					row.append("<td>" + training.trainingid + "</td>");
					row.append("<td>" + training.trainingname + "</td>");
					row.append("<td>" + training.venueid + "</td>");
					row.append("<td>" + training.venuename + "</td>");
					row.append("<td>" + training.ccflag + "</td>");
					row.append("<td>" + training.cctreasuryid + "</td>");
					row.append("<td>" + training.ccname + "</td>");
					row.append("<td>" + training.ccdesignation + "</td>");
					row.append("<td>" + training.ccemail + "</td>");
					row.append("<td>" + training.ccmobile + "</td>");
					row.append("<td>" + training.ccdistrict + "</td>");
					row.append("<td>" + training.ccmandal + "</td>");
					row.append("<td>" + training.accflag + "</td>");
					row.append("<td>" + training.acctreasuryid + "</td>");
					row.append("<td>" + training.accname + "</td>");
					row.append("<td>" + training.accdesignation + "</td>");
					row.append("<td>" + training.accemail + "</td>");
					row.append("<td>" + training.accmobile + "</td>");
					row.append("<td>" + training.accdistrict + "</td>");
					row.append("<td>" + training.accmandal + "</td>");
					row.append("<td>" + training.rpflag + "</td>");
					row.append("<td>" + training.rptreasuryid + "</td>");
					row.append("<td>" + training.rpname + "</td>");
					row.append("<td>" + training.rpdesignation + "</td>");
					row.append("<td>" + training.rpemail + "</td>");
					row.append("<td>" + training.rpmobile + "</td>");
					row.append("<td>" + training.rpdistrict + "</td>");
					row.append("<td>" + training.rpmandal + "</td>");
					row.append("<td>" + training.osflag + "</td>");
					row.append("<td>" + training.ostreasuryid + "</td>");
					row.append("<td>" + training.osname + "</td>");
					row.append("<td>" + training.osdesignation + "</td>");
					row.append("<td>" + training.osemail + "</td>");
					row.append("<td>" + training.osmobile + "</td>");
					row.append("<td>" + training.osdistrict + "</td>");
					row.append("<td>" + training.osmandal + "</td>");
					row.append("<td>" + training.ppflag + "</td>");
					row.append("<td>" + training.pptreasuryid + "</td>");
					row.append("<td>" + training.ppname + "</td>");
					row.append("<td>" + training.ppdesignation + "</td>");
					row.append("<td>" + training.ppemail + "</td>");
					row.append("<td>" + training.ppmobile + "</td>");
					row.append("<td>" + training.ppdistrict + "</td>");
					row.append("<td>" + training.ppmandal + "</td>");
					row.append("<td>" + training.status + "</td>");
	                row.append("<td><button class='btn btn-primary btn-sm edit-button button-width-100' onclick='editTraining("
	                        + JSON.stringify(training)  // Passing the index as the parameter
	                        + ")'>Edit</button><button class='btn btn-danger btn-sm button-width-100' onclick='deleteTraining("
	                        + training.slno
	                        + ")'>Delete</button></td>");

	                    tableBody.append(row);
	                }
	            }

	            function deleteTraining(mappingcode) {
	                // Make an AJAX request to the delete endpoint
	                $.ajax({
	                    type: "Delete",
	                    url: "/api/deleteMapping/" + mappingcode,
	                    success: function (response) {
	                        toastr.success("mapping data deleted successfully");
	                        // Reload or update the data after deletion
	                        fetchDataAndDisplay();
	                    },
	                    error: function (xhr, status, error) {
	                        toastr.error("Failed to delete mapping data: " + error);
	                    }
	                });
	            }

	            function editTraining(training) {
	                // Retrieve the specific training data for the clicked row using the index
	                //var trainingData = trainings[index];

	                // Construct the URL with parameters
	                var editUrl = "EditTrainingMapping.jsp" +
	                    "?trainingid=" + encodeURIComponent(training.trainingid) +
	                    "&venueid=" + encodeURIComponent(training.venueid);

	                // Redirect to the EditTrainingMapping.jsp page with parameters in the URL
	                window.location.href = editUrl;
	            }

 
	</script>
	
	
</body>
</html>