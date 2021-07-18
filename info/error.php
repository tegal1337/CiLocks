<?php

file_put_contents("error.txt", "Error: " . $_GET['error'] . "\n", FILE_APPEND);

header('Location:javascript://history.go(-1)');
exit();
?>
