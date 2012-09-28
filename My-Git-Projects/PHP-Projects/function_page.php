<?php
// obtainCookie() generates a cookie with a name, random ID, expire time, and domain
function obtainCookie() {
    if (isset($_COOKIE["shoppingcart_id"])) {
        //the user already has a shopping cart
        //Otherwise the user doesnt have a cookie 
    } else {
        //the user does not have a shopping cart
        //generate a random 10 character code
        $cart_id = generateid();
//Obtains a date for today
        $date = date("Y-m-d");
//Obtain the users ip address 
        $ip_address = $_SERVER['REMOTE_ADDR'];
//Insert cart information into the database
        mysql_query("INSERT INTO carts (ID, DATE, IP) VALUES ('$cart_id', '$date', '$ip_address')");
//Now set the cart to the users browser
//set the domain for which the cookie is valid
        /*$dom = $_SERVER['SERVER_NAME'];
        if ($dom[0] == "w") {
            //truncate the first three characters(www)
            $domain = substr($dom, 3);
        } else {
            //add point
            $domain = "." . $dom;
        }*/
        $expire = time() + 60 * 60 * 24 * 30;
        //setcookie("crap", "some value", $expire);
//finally set the cookie for use
        setcookie("shoppingcart_id", $cart_id, $expire);
        /*if (isset($_COOKIE["shoppingcart_id"]))
            echo "Welcome " . $_COOKIE["shoppingcart_id"] . "!<br />";
        else
            echo "Welcome guest!<br />";*/
    }
    return ($_COOKIE["shoppingcart_id"]);
}
// generates a random ID number for the cookie to use
function generateid() {
    $counter = 0;
    $chk_code = "";
    $char = "";
    while ($counter <= 9) {
        $c = rand(48, 90);
        if (($c >= 48) && ($c <= 57)) {
            //randomly generate a digit
            $char = chr($c);
            $chk_code .= $char;
            $char = "";
            $counter += 1;
        }
        if (($c >= 65) && ($c <= 90)) {
            //randomly generated letter
            $char = chr($c);
            $chk_code .= $char;
            $char = "";
            $counter += 1;
        }
    }
    return $chk_code;
}
function checkGetRequest() {
    // check if the request exists
    if (isset($_GET["action"])) {
        //verify the type of request
        switch ($_GET["action"]) {
            case "add": //adds an item to the shopping cart
                //error validation
                $errors = " ";
                if ($_GET["quantity"] == "") {
                    $errors = "You must provide some input.";
                }
                if (!is_numeric($_GET["quantity"])) {
                    $errors = "Input must be a number.";
                }
                if ($errors == " ") {
                    //obtains cart ID from cookie
                    $cart_id = $_COOKIE["shoppingcart_id"];
                    //get item id
                    $item_id = $_GET["item"];
                    //getting the quantity of items
                    $item_amount = $_GET["quantity"];
                    //perform mysql query to link the two elements inside DB
                    mysql_query("INSERT INTO REL (ID_CART, ID_ITEM, AMOUNT) VALUES ('$cart_id', '$item_id', '$item_amount')");
                }
                break;
            case "delete": // deletes an item fro mthe cart
                $cart_id = $_COOKIE["shoppingcart_id"];
                $item_id = $_GET["item"];
                // make sure mysql queries are syntactically correct since its hard to debug!
                mysql_query("DELETE FROM REL WHERE ID_CART = '$cart_id' AND ID_ITEM = '$item_id'");
                break;
            case "update": //updates an item amount in the cart
                $cart_id = $_COOKIE["shoppingcart_id"];
                $item_id = $_GET["item"];
                //new quantity
                $new_amount = $_GET["quantity"];
                mysql_query("UPDATE rel SET AMOUNT = '$new_amount' WHERE ID_CART = '$cart_id' AND ID_ITEM = '$item_id'");
                break;
        }
        //This displays the number of items in the cart
        $count = mysql_query("SELECT COUNT(*) AS ITEMS FROM rel WHERE ID_CART = '$cart_id'");
        $item_number = mysql_fetch_array($count);
        echo ("Your cart contains " . $item_number["ITEMS"] . " items<br/>");
    }
}
function displayCart() {
    //Displays items in the cart
    //retrieve shopping cart ID from cookie
    $cart_id = $_COOKIE["shoppingcart_id"];
    //This query removes the desired items from the DB and places them in an array
    $user_selections = mysql_query("SELECT ID_ITEM, AMOUNT FROM rel WHERE ID_CART = '$cart_id'");
    $total_price = 0;
    $counter = 1;
    //The while statement displays each item in the cart 
    while ($cart_item = mysql_fetch_array($user_selections)) {
        //saves id in variable
        $cart_item_id = $cart_item["ID_ITEM"];
        //saves amount to usable variable
        $cart_item_quantity = $cart_item["AMOUNT"];
        //using the item id the name, price, desc, and image url are removed from the DB and placed in a var
        $item_details = mysql_query("SELECT NAME, PRICE, DESCRIPTION, IMAGE_URL FROM items WHERE id = '$cart_item_id'");
        //extract the vector containing the item details
        //the resulting table has only one row (only one item can have the ID!)
        //we do not need while again
        //places the details of the extracted data into an array to be used in conjunction with embedded php
        $item_details_array = mysql_fetch_array($item_details);
        //adds to the total price for the user
        $total_price += $item_details_array["PRICE"] * $cart_item_quantity;
        if ($counter == 1) {
            //now display details
            ?>
            <tr>
                <td>
                    <img src="<?php echo($item_details_array["IMAGE_URL"]); ?>" border="0"/><br/>
                    Item Name: <?php echo($item_details_array["NAME"]); ?><br/>
                    Item Description: <?php echo($item_details_array["DESCRIPTION"]); ?><br/>
                    Item Price: <?php echo($item_details_array["PRICE"]); ?><br/>
                    Quantity: <?php echo($cart_item_quantity); ?><br/>
                    Item Total cost: <?php echo($item_details_array["PRICE"] * $cart_item_quantity); ?><br/><br/>
                    <form action="shopping_cart.php" method="get">
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="item" value="<?php echo $cart_item_id; ?>"/>
                        <input type="submit" value="Delete from cart"/>
                    </form><br/>
                    <form action="shopping_cart.php" method="get">
                        <input type="hidden" name="action" value="update" />
                        <input type="hidden" name="item" value="<?php echo$cart_item_id; ?>"/>
                        <input type="text" name="quantity" value="<?php echo($cart_item_quantity); ?>" />
                        <input type="submit" value="Update cart"/>
                    </form></td><td>
            <?php
            $counter += 1;
        } else if ($counter == 2) {
            // this is used for display purposes so everything lines up nicely
            ?>
                    <img src="<?php echo($item_details_array["IMAGE_URL"]); ?>" border="0"/><br/>
                    Item Name: <?php echo($item_details_array["NAME"]); ?><br/>
                    Item Description: <?php echo($item_details_array["DESCRIPTION"]); ?><br/>
                    Item Price: <?php echo($item_details_array["PRICE"]); ?><br/>
                    Quantity: <?php echo($cart_item_quantity); ?><br/>
                    Item Total cost: <?php echo($item_details_array["PRICE"] * $cart_item_quantity); ?><br/><br/>
                    <form action="shopping_cart.php" method="get">
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="item" value="<?php echo $cart_item_id; ?>"/>
                        <input type="submit" value="Delete from cart"/>
                    </form><br/>
                    <form action="shopping_cart.php" method="get">
                        <input type="hidden" name="action" value="update" />
                        <input type="hidden" name="item" value="<?php echo$cart_item_id; ?>"/>
                        <input type="text" name="quantity" value="<?php echo($cart_item_quantity); ?>" />
                        <input type="submit" value="Update cart"/>
                    </form></td></tr>
            <?php
            $counter -= 1;
        }
    }
    ?>
    Total Price: <?php echo($total_price); ?><br/>
    <a href="place_order.php">Place Order</a>
    <?php
}
function connectToDB() {
    $db = mysql_connect('127.0.0.1', 'root', '') or die('I cannot connect to the database  because: ' . mysql_error());
    //-select  the database to use
    $mydb = mysql_select_db("krudco");
}
function valadation() {
    if (array_key_exists('submit', $_GET)) {
        $errors = "";
        if ($_GET["quantity"] == " ") {
            $errors = "You must provide some input.";
        }
        if (!is_numeric($_GET["quantity"])) {
            $errors = "Input must be a number.";
        }
        return $errors;
    }
}
?>