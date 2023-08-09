<?php

class Customer{
    
    public $response = "";

   public $id = 0;
   public $name = "";
   public $username = "";
   public $password = "";
   public $confirm_password = "";
    
   public $lastname = "";
   public $address = "";
   public $email = "";
   public $phone = "";   
   public $number_of_orders = 0;   

}


session_start();
$conn = mysqli_connect('localhost','root','','laundry');


    
    
    
    
    $username = $_POST['username'];
    $password = $_POST['password'];
    
    if(empty($username) || empty($password)){
        echo 'empty';
        
//        header("Location: /pharmacy/?error=emptyfields");
        exit();
    }else{
        
        $sql = "SELECT * FROM laundry.customers where username = '$username';";
        
        $query = mysqli_query($conn, $sql);
        
        $result = mysqli_num_rows($query);
        
        
        if($result > 0){
            
            $row = mysqli_fetch_assoc($query);
            $upassword = $row['password'];
            
            $passwordverify = password_verify($password,$upassword);
//            
//            
            if(!$passwordverify){
                echo 'incorrect password';
                
                
//                header("Location: /pharmacy/?error=wronginput");
                exit();
                
            }else{
                
                $num_rows = mysqli_num_rows(mysqli_query($conn, 'SELECT * FROM receipts where customer_id = 6;'));
                
                
                $_SESSION['id'] = $row['id'];
                $_SESSION['name'] = $row['firstname'];
                $_SESSION['username'] = $row['username'];
                
                $customer = new Customer();
                $customer->id = $row['id'];
                $customer->name = $row['firstname'];
                
                $customer->response = 'successful';
                $customer->number_of_orders = $num_rows;
                
                $customer = json_encode($customer);
                echo $customer;
                
                
                
//                header("Location: /pharmacy/new/package/default/index-v1.php");
                exit();
                
               
            }
//            
        }else{
            
            echo 'incorrect username';
//            header("Location: /pharmacy/?error=wronginput1");
            exit();
        }
//        
//        
    }
        
        
    
    
    











