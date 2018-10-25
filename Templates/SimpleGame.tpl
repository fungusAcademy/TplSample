<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title> [title] </title>
    <script src="Scripts\app.js"></script>
    <script src="Scripts\class.js"></script>
    <link rel="stylesheet" href="Styles\style.css">
</head>
<body onload="Init();" onresize="Init();" onkeydown="HandleKeys(event);">
    <canvas id="canvas" onclick="CreateItem(event);"></canvas>
    <form>
        <input type="button" value="Random (1)" onclick="ChangeDirection('RANDOM');">
        <input type="button" value="Up (2)" onclick="ChangeDirection('UP');">
        <input type="button" value="Down (3)" onclick="ChangeDirection('DOWN');">
        <input type="button" value="Left (4)" onclick="ChangeDirection('LEFT');">
        <input type="button" value="Right (5)" onclick="ChangeDirection('RIGHT');">
        <input type="button" value="Diagonal (6)" onclick="ChangeDirection('DIAGONAL');">
        <input type="button" value="Spawn" onclick="SpawnItems();">
        
        <p><b>Max item size: </b></p>
        <input type="number" id="size" onchange="ChangeMaxSize();" placeholder="30">
        <p><b>Current speed: </b></p>
        <input type="number" id="speed" onchange="ChangeSpeed();" placeholder="5">
        <p><b>Spawn number: </b></p>
        <input type="number" id="spawn" onchange="ChangeSpawnNumber();" placeholder="10">
        <p><i> Spacebar - pause</i></p>
    </form>
</body>
</html>