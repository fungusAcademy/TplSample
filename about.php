<?php

	include("template.class.php");

	$profile = new Template("Templates\about.tpl");
	$profile->set("username", "Александр Горбатов");
	$profile->set("skill1", "Попадаю в первый конверт с разбежки");
	$profile->set("skill2", "Профессионально вытираю сплэши");
	$profile->set("skill3", "Могу следить за игрой, не выходя на поле");
	$profile->set("skill4", "Мастерски затираюсь на турнирах");
	$profile->set("biography", "– Я закончил стихийный факультет. На нем учат подчинять и контролировать некий элемент – это может быть какое-нибудь вещество, энергия или стихийная сила. Учат объединяться со своим элементом, становиться плоть от плоти с ним, кровь от крови. Обычно избирают Огонь, Воду, Лед, Молнию или еще что-нибудь такое же банальное. Но я – а до меня мой отец – избрал в качестве своего элемента Дерьмо.");

	$layout = new Template("Templates\layout.tpl");
	$layout->set("title", "About me");
	$layout->set("content", $profile->output());
	
	echo $layout->output();
	
?>