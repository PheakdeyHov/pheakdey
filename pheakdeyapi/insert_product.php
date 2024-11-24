<?php
include 'functions.php';

// Response to mobile app
$result = array("success" => 0, "error" => 0);

// Check if required fields are set
if (isset($_POST['ProductName']) && isset($_POST['CategoryID']) && isset($_POST['Barcode']) 
    && isset($_POST['Qty']) && isset($_POST['UnitPriceIn']) && isset($_POST['UnitPriceOut'])) {

    // Collect POST data
    $productName = $_POST['ProductName'];
    $category = $_POST['CategoryID'];
    $barcode = $_POST['Barcode'];
    $qty = $_POST['Qty'];
    $priceIn = $_POST['UnitPriceIn'];
    $priceOut = $_POST['UnitPriceOut'];

    // Define table fields and values
    $fields = array("ProductName", "CategoryID", "Barcode", "Qty", "UnitPriceIn", "UnitPriceOut");
    $values = array($productName, $category, $barcode, $qty, $priceIn, $priceOut);

    // Create an instance/object of the class functions
    $func = new functions();

    // Call method: insert_data()
    $insert = $func->insert_data('tblproduct', $fields, $values);

    if ($insert == true) {
        $result["success"] = 1;
        $result["msg_success"] = "Product inserted successfully.";
        print json_encode($result);
    } else {
        $result["error"] = 2;
        $result["msg_error"] = "Product insertion failed. Check database or query syntax.";
    }
} else {
    $result["error"] = 1;
    $result["msg_error"] = "Access denied or missing parameters.";
}

echo json_encode($result);
?>
