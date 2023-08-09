<?php



class Service_price{
    
    public $type_of_cloth = '';
    public $price = '';
    public $image_url = '';
    public $id = '';
    
    
}


$data = [];

$service_type = $_POST['service_type'];

$conn = mysqli_connect('localhost','root','','laundry');




$sql = "SELECT service_prices.id ,type_of_clothes.type_of_clothes, service_prices.price,type_of_clothes.image_url 
	           FROM laundry.service_prices
                inner join services on services.id = service_prices.services_id
                inner join type_of_clothes on type_of_cloth_id = type_of_clothes.id where services.service_name = '$service_type';";
        
        $query = mysqli_query($conn, $sql);

    if($query){
        
        
        while($row = mysqli_fetch_assoc($query)){
        
            $service_price = new Service_price();

            $service_price->type_of_cloth = $row['type_of_clothes'];
            $service_price->price = $row['price'];
            $service_price->image_url = $row['image_url'];
            $service_price->id = $row['id'];

            array_push($data, $service_price);
        
        
        
        }
        
        $data = json_encode($data);
        echo $data;
        
    }else{
        echo 'error';
    }

    

    
