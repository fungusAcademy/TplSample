<?php

	include("template.class.php");
	
	$profile = new Template("Templates\SimpleGame.tpl");
	
	$layout = new Template("Templates\layout.tpl");
	$layout->set("title", "Simple game");
	$layout->set("content", $profile->output());
	
	echo $layout->output();
	
?>