<!DOCTYPE html>
<html>
  <head>
    <title>d3 Tutorial</title>
    <!-- <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet"> -->
    <link href='css/bootstrap.css' rel='stylesheet' type='text/css'>
      <link href='css/styles.css' rel='stylesheet' type='text/css' />
    </link>
  </head>
  <body>
    <div class='jumbotron container'>
      <h1>D3</h1>
      <h2>SVG output</h2>
      <div class='row'>
        <div class='col-md-2'>
          <form class='frm-inline'>
            <label for='data-amount'>Amount of Data</label>
            <input class='form-control' id='data-amount' name='data-amount ' />
          </form>
        </div>
      </div>
      <div class='output'></div>
      <div class='svg-scatter'></div>
      <div class='btn btn-default btn-bargraph'>Bar Graph</div>
      <div class='btn btn-default btn-scatter'>Scatter Plot</div>
    </div>
    <script src='js/jquery.min.js'></script>
    <!-- <script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js?ver=1.4.2'></script> -->
    <script charset='utf-8' src='js/d3.min.js'></script>
    <script src='js/script.js'></script>
  </body>
</html>
