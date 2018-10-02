<?php

	include("template.class.php");
	
	$profile = new Template("Templates\main.tpl");
	$profile->set("intro", "Welcome to the simple website I made for my web classes!");
	$profile->set("description", "I have no idea about what to put on the main page, so just enjoy looking at my cats ^_^");
	
	$layout = new Template("Templates\layout.tpl");
	$layout->set("title", "Main page");
	$layout->set("content", $profile->output());
	
	echo $layout->output();
	
?>