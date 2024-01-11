<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    h1 {
        text-align: center;
        margin-top: 20px;
    }

    div {
        margin: 10px 0;
    }

    label {
        display: block;
        margin-bottom: 5px;
    }

    input {
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
    }

    select {
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
    }

    button {
        background-color: #4caf50;
        color: white;
        padding: 10px;
        border: none;
        cursor: pointer;
    }

    button:hover {
        background-color: #45a049;
    }
</style>
<meta charset="ISO-8859-1">
<title>Edit Venue</title>
<script>
    // Function to get URL parameters by name
    function getUrlParameter(name) {
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)");
        var results = regex.exec(location.search);
        return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }

    $(document).ready(function () {
        // Get field values from URL parameters
        var vdistrict = getUrlParameter("vdistrict");
        var vmandal = getUrlParameter("vmandal");

        // Set initial values in the input fields
        $("#vid").val(getUrlParameter("vid"));
        $("#vname").val(getUrlParameter("vname"));
        $("#vstatus").val(getUrlParameter("vstatus"));
        $("#vmandal").val(vmandal);
        $("#vdistrict").val(vdistrict);
        $("#vtype").val(getUrlParameter("vtype"));
        $("#vstate").val(getUrlParameter("vstate"));
        $("#vcapacity").val(getUrlParameter("vcapacity"));
        $("#vaddress").val(getUrlParameter("vaddress"));
        $("#landmark").val(getUrlParameter("landmark"));
        $("#vcontactname").val(getUrlParameter("vcontactname"));
        $("#vcontactno").val(getUrlParameter("vcontactno"));
        $("#vcontactmailid").val(getUrlParameter("vcontactmailid"));
        $("#vlocation").val(getUrlParameter("vlocation"));
        $("#maplocation").val(getUrlParameter("maplocation"));

        // Fetch districts after setting initial values
        fetchDistricts(vdistrict);
    });

    // Flags to check if dropdowns are already populated
    var districtDropdownPopulated = false;
    var mandalDropdownPopulated = false;

    // Variables to store fetched data
    var districtData;
    var mandalData;

    // Function to fetch districts
   // Function to fetch districts
function fetchDistricts(selectedDistrict) {
    $.ajax({
        url: '/api/search/districts',
        type: 'GET',
        dataType: 'json',
        success: function (data) {
            const districtDropdown = $('#vdistrict');
            // Clear existing options
            districtDropdown.empty();

            // Add the selected district as the first option
            districtDropdown.append('<option value="' + selectedDistrict + '">' + selectedDistrict + '</option>');

            // Populate the district dropdown
            data.forEach(district => {
                // Check if the option already exists
                if (district !== selectedDistrict && districtDropdown.find(`option[value="${district}"]`).length === 0) {
                    const option = $('<option></option>');
                    option.val(district);
                    option.text(district);

//                     // Preselect the district if it matches the selectedDistrict
//                     if (district === selectedDistrict) {
//                         option.prop('selected', true);
//                     }

                    districtDropdown.append(option);
                }
            });

            // Update flags and data variables
            districtDropdownPopulated = true;
            districtData = data;

            // If a district is selected, fetch and populate mandals
            if (selectedDistrict) {
                fetchMandals(selectedDistrict);
            }
        },
        error: function (error) {
            console.error('Error fetching district data:', error);
        }
    });
}

// Function to fetch mandals
var urlParams = new URLSearchParams(window.location.search);
var selectedMandal = urlParams.get('mandal');

function fetchMandals(selectedDistrict) {
    $.ajax({
        url: '/api/mandals?district=' + selectedDistrict,
        type: 'GET',
        dataType: 'json',
        success: function (data) {
            const mandalDropdown = $('#vmandal');
            // Clear existing options
            mandalDropdown.empty();

            // Add the selected mandal as the first option
            mandalDropdown.append('<option value="' + selectedMandal + '">' + selectedMandal + '</option>');

            // Populate the mandal dropdown
            data.forEach(mandal => {
                // Check if the option already exists
                if (mandal !== selectedMandal && mandalDropdown.find(`option[value="${mandal}"]`).length === 0) {
                    const option = $('<option></option>');
                    option.val(mandal);
                    option.text(mandal);
                    mandalDropdown.append(option);
                }
            });

            // Update data variable
            mandalData = data;
        },
        error: function (error) {
            console.error('Error fetching mandal data:', error);
        }
    });
}

    // Event handler for Save button
    $("#saveButton").click(function () {
        if (!validateForm()) {
            return;
        }

        // Get modified data from input fields
        var modifiedUid = $("#vid").val();
        var modifiedData = {
            vname: $("#vname").val(),
            vaddress: $("#vaddress").val(),
            vcapacity: $("#vcapacity").val(),
            vmandal: $("#vmandal").val(),
            vdistrict: $("#vdistrict").val(),
            vtype: $("#vtype").val(),
            vstate: $("#vstate").val(),
            vstatus: $("#vstatus").val(),
            maplocation: $("#maplocation").val(),
            status: $("#status").val(),
            vlocation: $("#vlocation").val(),
            vcontactname: $("#vcontactname").val(),
            vcontactmailid: $("#vcontactmailid").val(),
            landmark: $("#landmark").val()
        };

        // Perform AJAX request to update the data
        $.ajax({
            type: "PUT",  // Assuming you are using PUT method for updates
            url: "/api/updateVenue/" + modifiedUid,
            contentType: "application/json",
            data: JSON.stringify(modifiedData),
            success: function (response) {
                console.log("venue updated successfully");
                alert("venue updated successfully");
                window.location.href = "/VenueSetUp.jsp";
            },
            error: function (xhr, status, error) {
                console.error("Failed to update training: " + error);
                alert("Failed to update spell: " + error);
            }
        });
    });

    // Event handler for Exit button
    $("#exitButton").click(function () {
        window.location.href = "/VenueSetUp.jsp";
    });

    // Attach event listener to district dropdown
    $(document).on('change', '#vdistrict', function () {
        const selectedDistrict = $(this).val();
        if (selectedDistrict) {
            fetchMandals(selectedDistrict);
        }
    });

    function validateForm() {
        var requiredFields = ["vname", "vstate", "vdistrict", "vmandal", "vlocation", "vcapacity", "vaddress", "landmark", "vtype", "vcontactname", "vcontactno", "vcontactmailid", "maplocation", "vstatus"];
        var isValid = true;

        // Check each required field
        requiredFields.forEach(function (field) {
            var value = $("#" + field).val();

            if (value === null || value === "Select District") {
                alert("Please fill in all required fields.");
                isValid = false;
                return false; // Exit the loop early if any field is empty
            }
        });

        return isValid;
    }
</script>

</head>
<body>
    <h1>Edit Venue</h1>
    <div>
        <label for="vid">Venue Id:</label>
        <input type="text" id="vid" readonly>
    </div>
    <div>
        <label for="vname">Venue Name:</label>
        <input type="text" id="vname" placeholder="Enter venue name" required>
    </div>
    <div>
        <label for="vstate">Venue State:</label>
        <input type="text" id="vstate" placeholder="Enter state" required>
    </div>
    <div>
        <label for="vdistrict">Venue District:</label>
        <select id="vdistrict" placeholder="Enter district" required></select>
    </div>
    <div>
        <label for="vmandal">Venue Mandal:</label>
        <select id="vmandal" placeholder="Enter mandal" required></select>
    </div>
    <div>
        <label for="vlocation">Venue Location :</label>
        <input type="text" id="vlocation" placeholder="Enter Venue Location" required>
    </div>
    <div>
        <label for="vcapacity">Venue Capacity:</label>
        <input type="text" id="vcapacity" placeholder="Enter Venue Capacity" required  pattern="\d*"   
							 oninput="this.value = this.value.replace(/[^0-9]/g, '');">
    </div>
    <div>
        <label for="vaddress">Venue Address:</label>
        <input type="text" id="vaddress" placeholder="Enter Venue Address" required>
    </div>
    <div>
        <label for="landmark">Landmark:</label>
        <input type="text" id="landmark" placeholder="Enter Landmark" required>
    </div>
    <div>
        <label for="vtype">Venue Type:</label>
        <input type="text" id="vtype" placeholder="Enter Venue Type" required>
    </div>
    <div>
        <label for="vcontactname">Venue Co-Ordinator Name:</label>
        <input type="text" id="vcontactname" placeholder="Enter Co-Ordinator Name" required>
    </div>
    <div>
        <label for="vcontactno">Venue Co-Ordinator Mobile:</label>
        <input type="text" id="vcontactno" placeholder="Enter MobileNo" required   pattern="\d*"   
							 oninput="this.value = this.value.replace(/[^0-9]/g, '');">
    </div>
    <div>
        <label for="vcontactmailid">Venue Co-Ordinator Email:</label>
        <input type="text" id="vcontactmailid" placeholder="Enter Email" required>
    </div>
    <div>
        <label for="maplocation">Map Location:</label>
        <input type="text" id="maplocation" placeholder="Enter maplocation" required>
    </div>
    <div>
        <label for="vstatus">Venue Status:</label>
        <input type="text" id="vstatus" placeholder="Enter Status" required>
    </div>
    <button id="saveButton">Save</button>
    <button id="exitButton">Exit</button>
</body>
</html>
