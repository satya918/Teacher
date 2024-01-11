<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Training Management Mapping</title>
    <style>
    
    
        #resultTable, #mappingTable, #mapButton {
            display: none;
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        #resultTable th, #resultTable td, #mappingTable th, #mappingTable td {
            border: 1px solid blue;
            padding: 8px;
            text-align: left;
        }

        #resultTable th, #mappingTable th {
            background-color: #73e6de;
        }

        .field {
            margin-bottom: 10px;
        }
    </style>
    <style>
    /* Add some padding and space around the table */
.field {
    padding: 10px;
}

/* Style the table */
#resultTable {
    width: 100%;
    border-collapse: collapse;
}

/* Add some padding and a white background color to the table headers */
#resultTable th {
    background-color: #73e6de;
    color: #333;
    padding: 8px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

/* Add some padding and a white background color to the table cells */
#resultTable td {
    background-color: #fff;
    color: #333;
    padding: 8px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

/* Add a hover effect on the table rows */
#resultTable tr:hover {
    background-color: #f2f2f2;
}
    </style>
    
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>

    <h1 align="center">Training Management Mapping</h1>

    <div class="field">
        <label for="dropdown">Select a management:</label>
        <select id="dropdown">
            <!-- Placeholder option -->
            <option value="" disabled selected>Select a teacher</option>
        </select>
    </div>
    
    <div class="field">
        <label for="trainingname">Select a Training:</label>
        <select id="trainingname">
            <!-- Placeholder option -->
            <option value="" disabled selected>Select a Training</option>
        </select>
    </div>

    <div class="field">
        <label for="treasuryId">Treasury ID:</label>
        <input type="text" id="treasuryId">
    </div>

    <div class="field">
        <button onclick="search()">Search</button>
    </div>

    <div class="field">
        <table id="resultTable">
            <thead>
                <tr>
                    <th>Teacher Name</th>
                    <th>District</th>
                    <th>Designation</th>
                    <th>Email</th>
                    <th>Mobile</th>
                </tr>
            </thead>
            <tbody id="tableBody">
                <!-- Table body content will be populated dynamically -->
            </tbody>
        </table>
    </div>

    <div class="field" id="mapButton">
        <button onclick="showMapping()">Map</button>
    </div>

    <div class="field">
        <table id="mappingTable">
            <thead>
                <tr>
                	<th>Training Name</th>
                	
                    <th>Selected Management</th>
                    <th>Teacher Name</th>
                    <th>District</th>
                    <th>Designation</th>
                    <th>Email</th>
                    <th>Mobile</th>
                </tr>
            </thead>
            <tbody id="mappingTableBody">
                <!-- Table body content will be populated dynamically -->
            </tbody>
        </table>
    </div>

    <script>
        function fetchData() {
            $.ajax({
                type: "GET",
                url: "api/Allmanagement",
                success: function(data) {
                    const dropdown = document.getElementById('dropdown');
                    dropdown.innerHTML = '<option value="" disabled selected>Select a teacher</option>'; // Clear previous content

                    data.forEach(option => {
                        const optionElement = document.createElement('option');
                        optionElement.value = option.management_name;
                        optionElement.textContent = option.management_name;
                        dropdown.appendChild(optionElement);
                    });
                },
                error: function(error) {
                    console.error('Error fetching data:', error);
                }
            });
        }
        $.ajax({
            type: "GET",
            url: "/api/scheduledTrainings1",
            success: function(data) {
                const trainingDropdown = document.getElementById('trainingname');
                trainingDropdown.innerHTML = '<option value="" disabled selected>Select a Training</option>'; // Clear previous content

                data.forEach(training => {
                    const trainingOption = document.createElement('option');
                    trainingOption.value = training.tname;
                    trainingOption.textContent = training.tname;
                    trainingDropdown.appendChild(trainingOption);
                });
            },
            error: function(error) {
                console.error('Error fetching training data:', error);
            }
        });
    

        function search() {
            const treasuryId = document.getElementById('treasuryId').value.trim();

            // Validate treasuryId
            if (!treasuryId) {
                alert('Please enter a valid Treasury ID.');
                return;
            }

            $.ajax({
                type: "GET",
                url: "/api/findteachers?treasuryid=" + treasuryId,
                success: function(response) {
                    console.log(response); // Log the response to the console

                    const tableBody = document.getElementById('tableBody');
                    tableBody.innerHTML = ''; // Clear previous content

                    if (response.length > 0) {
                        const teacher = response[0];

                        const row = document.createElement('tr');
                        appendTableCell(row, teacher.teacher_name);
                        appendTableCell(row, teacher.districtnamewrk);
                        appendTableCell(row, teacher.designation);
                        appendTableCell(row, teacher.mobilenumberteacher);
                        appendTableCell(row, teacher.email);
                        tableBody.appendChild(row);

                        document.getElementById('resultTable').style.display = 'block';
                        document.getElementById('mapButton').style.display = 'block';
                    } else {
                        document.getElementById('resultTable').style.display = 'none';
                        document.getElementById('mapButton').style.display = 'none';
                        alert('No matching data found for the given Treasury ID.');
                    }
                },
                error: function(error) {
                    console.error('Error fetching teacher data:', error);
                    alert('Error fetching teacher data. Please try again.');
                }
            });
        }

        function showMapping() {
            const selectedTeacher = document.getElementById('dropdown').value;
            const selectedTraining = document.getElementById('trainingname').value;


            // Validate selectedTeacher
            if (!selectedTeacher) {
                alert('Please select a teacher first.');
                return;
            }
            
            if (!selectedTraining) {
                alert('Please select a training first.');
                return;
            }

            const tableBody = document.getElementById('mappingTableBody');
            tableBody.innerHTML = ''; // Clear previous content

            // Assuming 'tableBody' in the mapping table has the same structure as the first table
            const originalTableBody = document.getElementById('tableBody');

            // Iterate through rows in the original table and create corresponding rows in the mapping table
            for (let i = 0; i < originalTableBody.rows.length; i++) {
                const originalRow = originalTableBody.rows[i];
                const mappingRow = document.createElement('tr');

                // Add a cell with the selected teacher's name
                const selectedTeacherCell = document.createElement('td');
                selectedTeacherCell.textContent = selectedTraining;
                mappingRow.appendChild(selectedTeacherCell);
                
                
                const selectedTrainingCell = document.createElement('td');
                selectedTrainingCell.textContent = selectedTeacher;
                mappingRow.appendChild(selectedTrainingCell);

                // Iterate through cells in the original row and create corresponding cells in the mapping row
                for (let j = 0; j < originalRow.cells.length; j++) {
                    const originalCell = originalRow.cells[j];
                    const mappingCell = document.createElement('td');
                    mappingCell.textContent = originalCell.textContent;
                    mappingRow.appendChild(mappingCell);
                }

                tableBody.appendChild(mappingRow);
            }

            document.getElementById('mappingTable').style.display = 'block';
        }

        function appendTableCell(row, data) {
            const cell = document.createElement('td');
            cell.textContent = data;
            row.appendChild(cell);
        }

        // Call fetchData function to populate the dropdown on page load
        fetchData();
    </script>

</body>
</html>
