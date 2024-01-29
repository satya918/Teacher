<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Training Details</title>
    <style>
        .field-container {
            margin-bottom: 10px;
        }

        .group-container {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        // Function to get URL parameters by name
        function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            name = name.replace(/[\[\]]/g, "\\$&");
            var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, " "));
        }

        // Retrieve trainingid and venueid from the URL
        var trainingId = getParameterByName('trainingid');
        var venueId = getParameterByName('venueid');

        // Make an AJAX call to the API endpoint with trainingid and venueid
        $.ajax({
            type: "GET",
            url: "/api/training/mapped?trainingid=" + trainingId + "&venueid=" + venueId,
            dataType: "json",
            success: function (data) {
                // Handle the API response data here
                var trainingDetails = data[0]; // Assuming there is only one training in the response

                // Displaying values on the UI
                console.log("Training Details:", trainingDetails);

                // Displaying other fields in a separate container
                var containerHtml = '';

                // Looping through each field
                for (var key in trainingDetails) {
                    if (trainingDetails.hasOwnProperty(key)) {
                        // Checking if the value is a string before using split
                        var fieldValues = (typeof trainingDetails[key] === 'string') ? trainingDetails[key].split(',') : [trainingDetails[key]];

                        // Creating a group container for each key
                        containerHtml += '<div class="group-container">'; 
                        for (var i = 0; i < fieldValues.length; i++) {
                            containerHtml += '<div class="field-container"><strong>' + key + ':</strong> ' + fieldValues[i] + '</div>';
                        }
                        containerHtml += '</div>';
                    }
                }

                // Appending container to the body
                $('body').append(containerHtml);
            },
            error: function (xhr, status, error) {
                console.error("API request error: " + error);
            }
        });
    </script>

    <!-- Other HTML content -->

</body>
</html>
