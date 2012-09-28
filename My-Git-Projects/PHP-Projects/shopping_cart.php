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
        ?>
        <title>Shopping Cart</title>
    </head>
    <body>
        <div id="wrap">
            <br/>
            <table width="100%">
            <tr>
                <td> <h1>Shopping Cart</h1>
        <table width="100%" >
                     <tr>
                         
                         <td><?php
                         $shoppingcart_id = obtainCookie();
                         checkGetRequest();
                         displayCart();
                         
                         ?></td>
                     </tr>
                 </table>
                </td>
        </tr>
        </table>
        <?php
        // put your code here
        ?>
        </div>
    </body>
</html>