/*
 *  Admin Flight Data Example
 * 
 *  This data is mocked up and is used to visualize the charts
 *  on /AdminFlightSelections
 *  
*/

// Bar Chart Data
var barChartData = {
    labels: ["Breakfast", "Lunch", "Dinner"],
    datasets: [
        {
            label: "Business",
            fillColor: "rgba(220,220,220,0.5)",
            strokeColor: "rgba(220,220,220,0.8)",
            highlightFill: "rgba(220,220,220,0.75)",
            highlightStroke: "rgba(220,220,220,1)",
            data: [30, 12, 9]
        },
        {
            label: "Coach",
            fillColor: "rgba(151,187,205,0.5)",
            strokeColor: "rgba(151,187,205,0.8)",
            highlightFill: "rgba(151,187,205,0.75)",
            highlightStroke: "rgba(151,187,205,1)",
            data: [10, 3, 25] 
        }
    ]
};

// Data is mocked, 
var doughnutChartData = [
     {
        value: 89,
        color: "#46BFBD",
        highlight: "#5AD3D1",
        label: "Meals Preselected"
    },
    {
        value: 15,
        color: "#FDB45C",
        highlight: "#FFC870",
        label: "Meals Not Selected"
    }
];

