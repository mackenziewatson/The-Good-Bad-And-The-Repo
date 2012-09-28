<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="site_layout.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <?php 
        error_reporting(1);
            include ("site_header_footer.php");
        ?>
        <title>Search</title>
    </head>
    <body>
        <div id="wrap">
            <br/>
            <table width="100%">
            <tr>
                <td>
        <table width="100%" >
                     <tr>
                         
                         <td>
            <?php
                echo "<h2 id=\"result\">&nbsp&nbspSearch Results:</h2>";
                //If search button was pressed
                if(isset($_POST['submit'])){
                //Checks address bar for a certain value
                if(isset($_GET['go'])){
                //Only capital and lower case letters allowed, to prevent SQL Injection
                if(preg_match("/[A-Z  | a-z]+/", $_POST['name'])){
                    //Store search terms in $name
                $name=$_POST['name'];
                //connect  to the database
                $db=mysql_connect('127.0.0.1', 'root','') or die ('I cannot connect to the database  because: ' . mysql_error());
                //-select  the database to use
                //$mydb=mysql_select_db("phpdb");
                $mydb=mysql_select_db("krudco");
                //$sql="SELECT Content FROM webpages WHERE  Title LIKE '%" . $name . "%'";
                $sql="SELECT link FROM websites WHERE content LIKE '%" . $name . "%'";
                $result=mysql_query($sql);
                while ($row=mysql_fetch_array($result)){
                  //$page = $row['Content'];
                    $page = $row['link'];
                   echo "<ul>\n";
                   echo "<li>" . "<a href=\"$page\">" . $page;
                   echo "</ul>";
                    }
                 }
                else{
                echo  "<p>Please enter a search query</p>";
                 }
             }
             }
            ?>
                         </td>
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

