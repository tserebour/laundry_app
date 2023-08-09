<?php





$conn = mysqli_connect('localhost','root','','laundry');


    
        
        
        $username= $_POST['username'];
        $firstname = $_POST['firstname'];
        $lastname = $_POST['lastname'];
        $phone = $_POST['phone'];
        $email = $_POST['email'];
        $address = $_POST['address'];
//        $manager_password = $_POST['manager_password'];
        $password= $_POST['password'];
        $confirm_password = $_POST['confirm_password'];
//        $manager_overwrite_password = "Tinsters";
        
        
        
        
        if(empty($username)  || empty($password) || empty($confirm_password) || empty($firstname) || empty($lastname) || empty($phone) || empty($email) || empty($address)){
            
            echo 'empty';
//            header("Location: /pharmacy/?error=emptyfields");
//            
//            exit();
        }else{
                
                if(!preg_match("/^[a-zA-Z0-9]*$/", $username)){
                    
                    echo 'username error';
//                   header("Location: /pharmacy/?error=usernameerror");
                    exit();  
                    
                }else{
                    
                    
                        
                        if(strlen($password) < 5){
                                
                            echo 'password length';
//                            header("Location: /pharmacy/?error=passwordlengtherror");
                            exit();
                            
                        }else{
                            
                            if($password != $confirm_password){
                                    echo 'password error';
//                                header("Location: /pharmacy/?error=confirmpassworderror");
                                exit();
                            }else{
                                
                                $sql = "SELECT * FROM laundry.customers where username = '$username';";
                                $query = mysqli_query($conn, $sql);
                                
                                $resultcheck = mysqli_num_rows($query);
                                    
                                    if($resultcheck > 0){
                                           echo 'username taken'; 
//                                        header("Location: /pharmacy/?error=usernametaken");
                                        exit();
                                    }else{
                                        
                                        
//                                        $emloyee = new employee($name, $username, $password);
//                                       $insert =  $emloyee->insert_into_employee();
                                        
                                        $password= password_hash($password, PASSWORD_DEFAULT);
                                        
                                        $sql = "INSERT INTO `laundry`.`customers` (`firstname`, `lastname`, `username`, `email`, `phone`, `address`, `password`) 
                                                    VALUES ('$firstname', '$lastname', '$username', '$email', '$phone', '$address', '$password');";
                                        
                                        $query = mysqli_query($conn, $sql);
                                        
                                        if($query){
                                            
                                            echo 'successful';
//                                            header("Location: /pharmacy/?error=successful");
                                            exit();
                                            
                                        }else{
                                                echo 'not inserted';
//                                            header("/pharmacy/?error=notinserted");
                                            exit();
                                        }
                                                    
                                         
                                          
                                            
                                        }
                                            
                                            
                               
                            }
                        }
                    }
                }
            
            
        
        
      
        
        
    
    

