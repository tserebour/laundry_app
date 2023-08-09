<?php

$conn = mysqli_connect('localhost','root','','laundry');


$receipt = $_POST['data'];

$receipt = json_decode($receipt);
//print_r($receipt);
$customer = $receipt->customer;
$customer_id = $customer->id;
$total_amount = $receipt->total_amount;

$done = false;


$sql = "INSERT INTO `laundry`.`receipts` (`customer_id`, `date_time`, `total_amount`) VALUES ('$customer_id', now(), '$total_amount');";

$query = mysqli_query($conn, $sql);


$receipt_id = mysqli_insert_id($conn);


if($query){
    
    $done = false;
    
    $orderlist = $receipt->orders;
    
    
    
    
    for ($i = 0; $i< count($orderlist); $i++){
        
        $order = $orderlist[$i];
        
        $service_price = $order->service_prices;
        $service_price_id = $service_price->id;
        $quantity = $order->quantity;
        $price = $order->price;
        
        $sql = "INSERT INTO `laundry`.`orders` (`receipt_id`, `service_prices_id`, `quantity`, `price`) 
                                        VALUES ('$receipt_id', '$service_price_id', '$quantity', '$price');";

        $query = mysqli_query($conn, $sql);
        
        if($query){
            $done = true;
        }else{
            $done = false;
        }
        
    }
    
    
    
    
    
    
        
    
}
else{
    $done = false;
}

if($done){
    echo 'successful';
}else{
    echo 'error';
}





