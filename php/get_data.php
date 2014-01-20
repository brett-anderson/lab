<?php
  //uncomment and adjust the following line if using localDB
  $dbconn = pg_connect("host=localhost port=5432 dbname=SMT user=SMT password=moisture99"); //localDB
  //uncomment and adjust the following line if using live DB
  // $dbconn = pg_connect("host=localhost port=5432 dbname=SMT user=SMTRead"); //liveDB

  // $amount = $_POST['rows'];
  // $query = $_POST['query'];
  // $query = "select * from \"v_Weather\" limit {$amount}";
  $query = 'SELECT * FROM "pData_2013_27" limit 70' ; 

  $result = pg_query($dbconn, $query);
  $data = array();
  while($row = pg_fetch_assoc($result)) {

    // $row['ts'] = strtotime($row['ts']);
    array_push($data, $row); 
  }
  echo json_encode($data);
?>