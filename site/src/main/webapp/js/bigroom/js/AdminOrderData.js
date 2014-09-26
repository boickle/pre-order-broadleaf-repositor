/*
 *  Admin Order Data Example
 * 
 *  This data is mocked up and is used to visualize the charts
 *  on /AdminPreOrders
 *  
 */

// Bar Chart Data
var barChartData = {
    labels: ["Duty Free", "Electronics", "Entertainment", "Food & Drink"],
    datasets: [
        {
            label: "Business",
            fillColor: "rgba(220,220,220,0.5)",
            strokeColor: "rgba(220,220,220,0.8)",
            highlightFill: "rgba(220,220,220,0.75)",
            highlightStroke: "rgba(220,220,220,1)",
            data: [30, 12, 9, 23]
        },
        {
            label: "Coach",
            fillColor: "rgba(151,187,205,0.5)",
            strokeColor: "rgba(151,187,205,0.8)",
            highlightFill: "rgba(151,187,205,0.75)",
            highlightStroke: "rgba(151,187,205,1)",
            data: [10, 3, 25, 50 ] 
        }
    ]
};

// Data is mocked, 
var doughnutChartData = [
    {
        value: 300,
        color:"#F7464A",
        highlight: "#FF5A5E",
        label: "Duty Free"
    },
    {
        value: 180,
        color:"#39C",
        highlight: "#4AD",
        label: "Electronics"
    },
    {
        value: 90,
        color:"#F90",
        highlight: "#FA1",
        label: "Entertainment"
    },
    {
        value: 230,
        color: "#46BFBD",
        highlight: "#5AD3D1",
        label: "Food & Drink"
    },
    {
        value: 80,
        color: "#FDB45C",
        highlight: "#FFC870",
        label: "Jewlery and Watches"
    }
];

