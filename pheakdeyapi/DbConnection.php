<?php

    //connection
    class DbConnection {
        private $hostname = 'localhost';
        private $username = 'root';
        private $password = '';
        private $database = 'pheakdey';

        // Function for connection to xampp
        public function connect() {
            try {
                $conn = new mysqli(
                    $this->hostname,
                    $this->username,
                    $this->password,
                    $this->database
                );
                return $conn;
            }
            catch(\Exception $ex){
                echo "Error : " . $ex->getMessage();
            }
        }
    }


?>