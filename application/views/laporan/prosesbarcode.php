
<?php

include('bar128.php');
echo '<div style="border:1px double #ababab; padding:0px;margin:0px auto;width:180px;">';
//$jml = $_POST['jml'];
$bar=$_POST['bar'];



?>

<style type="text/css">
		body{
			font-family: sans-serif;
		}
 
		.lingkaran1{
			width: 200px;
			height: 200px;
			background: #dac52c;
			border-radius: 100%;
		}
 
		.lingkaran2{
			width: 140px;
			height: 140px;
			background: #ff0000;
			border-radius: 100%;
		}
	</style>
	<table border="1"  cellpadding="0" cellspacing="0" align="center" >
	<tr><td>
<table  class="vendorListHeading"  border="0"  width="250px" cellpadding="0" cellspacing="0" align="center" >


<tr  bgcolor="white">
<td colspan="3" align="center"><?php echo bar128(stripslashes($_POST['bar'])); ?></td>
</tr>

</table>
</tr></td>
</table>
<?php
echo '</div>';
?>



