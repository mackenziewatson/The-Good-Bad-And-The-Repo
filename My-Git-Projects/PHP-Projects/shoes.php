<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="site_layout.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <?php 
        error_reporting(1);
            include ("site_header_footer.php");
            include ("function_page.php");
            connectToDB();
            $shoppingcart_id = obtainCookie();
        ?>
        <title>Shoes</title>
    </head>
     <body>
        <div id="wrap">
            <br/>
            <table width="100%">
            <tr>
                <td><h1>Shoes</h1>
        <table width="100%" >
             <tr>
              <?php
              $counter = 1;
          $items = mysql_query("SELECT ID, NAME, PRICE, IMAGE_URL FROM items WHERE DESCRIPTION LIKE 'Res%'");
       while($item = mysql_fetch_array($items))
         {
           if($counter == 1){
       ?>
                 <tr>
                 <td>
       <img src="<?php echo ($item["IMAGE_URL"]); ?>" /><br/>
       Item name: <?php echo ($item["NAME"]); ?>
       <form action="shoes.php" method="get">
           <input type ="hidden" name="action" value="add" />
           <input type="text" name ="quantity" value="1"/><br/>
           <input type="hidden" value="<?php echo($item["ID"]); ?>" name="item"/>
           <input type="submit" value="Add to cart"/>
       </form>
       <form action="shoes.php" method="get">
           <input type="hidden" value="<?php echo($item["ID"]); ?>" name="item"/>
           <input type="hidden" value="delete" name="action"/>
           <input type="submit" value="Delete from cart"/>
       </form></td><td>
       
       <?php
       $counter += 1;

           }
           
       else if ($counter == 2){
              ?>
              
             
       <img src="<?php echo ($item["IMAGE_URL"]); ?>" /><br/>
       Item name: <?php echo ($item["NAME"]); ?>
       <form action="shoes.php" method="get">
           <input type ="hidden" name="action" value="add" />
           <input type="text" name ="quantity" value="1"/><br/>
           <input type="hidden" value="<?php echo($item["ID"]); ?>" name="item"/>
           <input type="submit" value="Add to cart"/>
       </form>
       <form action="shoes.php" method="get">
           <input type="hidden" value="<?php echo($item["ID"]); ?>" name="item"/>
           <input type="hidden" value="delete" name="action"/>
           <input type="submit" value="Delete from cart"/>
       </form></td></tr>
       
       <?php 
       $counter -= 1;

           }
         }
                         ?>
                         
                     </tr>
                     <tr>
                         
                     </tr>
                 </table>
                </td>
        </tr>
        </table>
        <?php
        checkGetRequest();
        ?>
        </div>
    </body>
</html>