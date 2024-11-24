<?php

    class functions {
        //data members or member variables
        private $db;
        private $sql;
        private $result;

        //constructor
        function __construct()
        {
            require_once 'DbConnection.php';
            // creating an instance of class DbConnection
            $this->db = new DbConnection();

            // calling the method: connect() of class DbConnection
            $this->db->connect();
        }

        //destructor
        function __destruct()
        {
            $this->db->connect()->close();
        }
        //methods
        public function insert_data($tablename, $fields, $values){
            //count fields in array
            $count = count($fields);
            // generate insert statement
            // syntax: INSERT INTO tablename(col1,col2,...) VALUES(val1, val2, ...);
            $this->sql = "INSERT INTO $tablename(";

            for($i=0;$i<$count;$i++){
                $this->sql .= $fields[$i];

                if($i < $count -1){
                    $this->sql .= ", ";
                }
                else {
                    $this->sql .= ") VALUES(";
                }
            }
            for($j = 0; $j < $count; $j++){
                $this->sql .= "'".$values[$j]."'";

                if($j < $count - 1){
                    $this->sql .= ", ";
                }
                else {
                    $this->sql .= ");";
                }
            }
            // execute insert statement
            $this->result = $this->db->connect()->query($this->sql);
            if($this->result === TRUE){
                return true;
            }
            else {
                return false;
            }
        }

    }

?>