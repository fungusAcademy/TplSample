 <head>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/mootools/1.6.0/mootools-core.js"></script>
    <script>
        var canvas, ctx, balls, rects, idTimer, accelerate = 20, test, SizeLimit=50, FiguresLimit=40, prevType, isStop=true, lenInc=0.5;
        
        TFigure = new Class(
        {
            initialize: function(pX, pY)
            {
                this.posX = pX; 
                this.posY = pY - 30; 
                this.colorFigure =
                    'rgb(' + Math.floor(Math.random() * 256) + ',' +
                    Math.floor(Math.random() * 256) + ',' + Math.floor(Math.random() * 256) + ')';
                this.len = 5 + Math.random() * 25;
                this.directionX = (Math.random() < 0.65) ? -1 : 1;
                this.directionY = (Math.random() < 0.25) ? -1 : 1;
                this.correction = Math.random() * 1.5;
            },
            
            posX: 0,
            posY: 0,
            colorFigure: "rgb(0,0,0)",
            len: 0,
            directionX: 1,
            directionY: 1,
            correction: 0,
            colorGen: function(ctx)
            {
                with(this)
                {
                    var gradient =
                        ctx.createRadialGradient(posX + len / 4,
                        posY - len / 6, len / 8, posX, posY, len);
                    gradient.addColorStop(0, '#fff');
                    gradient.addColorStop(0.85, colorFigure);
                    return gradient;
                }
            }
        });
        
        TBall = new Class(
        {
            Extends: TFigure,
            initialize: function(X, Y)
            {
                this.parent(X, Y);
            },
            
            draw: function(ctx)
            {
                with(this)
                {
                    ctx.fillStyle = colorGen(ctx);
                    ctx.beginPath();
                    ctx.arc(posX, posY, len, 0, 2 * Math.PI, false);
                    ctx.closePath();
                    ctx.fill();
                }
            }
        });
        
        TPackMan = new Class(
        {
            Extends: TFigure,
            initialize: function(X, Y)
            {
                this.parent(X, Y);
            },
            
            draw: function(ctx)
            {
                with(this)
                {
                    ctx.fillStyle = colorGen(ctx);
                    ctx.beginPath();
                    ctx.arc(posX, posY, len, Math.PI /4 ,
                            7 * Math.PI / 4, false);
                    ctx.lineTo(posX, posY);
                    ctx.closePath();
                    ctx.fill();
                }
            }
        });
        
        TRect = new Class(
        {
            Extends: TFigure,
            initialize: function(X, Y)
            {
                this.parent(X,Y);
            },
            
            colorGen: function(ctx)
            {
                with(this)
                {
                    var gradient =ctx.createLinearGradient
                        (posX, posY, posX + len, posY + len);
                    gradient.addColorStop(0, '#fff');
                    gradient.addColorStop(0.5, colorFigure);
                    return gradient;
                }
            },
            draw: function(ctx)
            {
                with(this)
                {
                    ctx.fillStyle = colorGen(ctx);
                    ctx.fillRect(posX, posY, len, len);
                }
            }

        });
        
        TRectBall = new Class(
        {
            Extends: TRect,
            initialize: function(X, Y)
            {
                this.parent(X,Y);
            },
            draw: function(ctx)
            {
                with(this)
                {
                    var halfLen = len / 2;
                    ctx.fillStyle = colorGen(ctx);
                    ctx.beginPath();
                    ctx.strokeRect(posX, posY, len, len);
                    ctx.arc(posX + len/2, posY + len/2,
                            len/2, 0, 2 * Math.PI, false);
                    ctx.fill();
                    ctx.closePath();
                    ctx.fillStyle = colorGen(ctx);
                    ctx.beginPath();
                    ctx.moveTo(posX+halfLen, posY);
                    ctx.lineTo(posX+halfLen, posY+len);
                    ctx.lineTo(posX+len, posY+halfLen);
                    ctx.lineTo(posX, posY+halfLen);
                    ctx.lineTo(posX+halfLen, posY);
                    ctx.stroke();
                    ctx.fill();
                }
            } 
        });
        
        function drawBack(ctx, col1, col2, w, h)
        {
            ctx.save();
            var g = ctx.createLinearGradient(0, 0, 0, h);
            g.addColorStop(1, col1);
            g.addColorStop(0, col2);
            ctx.fillStyle = g;
            ctx.fillRect(0, 0, w, h);
            ctx.restore();
        }
        
        function init()
        {
            canvas = document.getElementById('canvas');
            canvas.width = window.innerWidth - 5;
            canvas.height = window.innerHeight / 2;
            
            if (canvas.getContext)
            {
                ctx = canvas.getContext('2d');
                drawBack(ctx, '#202020', '#aaa',
                         canvas.width, canvas.height);
                balls = [];
                rects = [];
                for (var i = 0; i < FiguresLimit; i++)
                {
                    var item = new TBall(
                        10 + Math.random() * (canvas.width - 30),
                        10 + Math.random() * (canvas.height - 30));
                    
                    item.draw(ctx);
                    balls.push(item);
                    
                    var itemRect = new TRect(
                        10 + Math.random() * (canvas.width - 30),
                        10 + Math.random() * (canvas.height - 30));
                    
                    itemRect.draw(ctx);
                    rects.push(itemRect);
                    
                    var itemPackMan = new TPackMan(
                        10 + Math.random() * (canvas.width - 30),
                        10 + Math.random() * (canvas.height - 30));
                    
                    itemPackMan.draw(ctx);
                    balls.push(itemPackMan);
                    
                    var itemRectBall = new TRectBall(
                        10 + Math.random() * (canvas.width - 30),
                        10 + Math.random() * (canvas.height - 30));
                    
                    itemRectBall.draw(ctx);
                    rects.push(itemRectBall);
                }
                
            }
        }
        
        function goInput(event)
        {
            var x = event.clientX + window.pageXOffset;
            var y = event.clientY + window.pageYOffset;
            var rand = Math.random();
            if(rand < 0.25)
            {
                var item = new TBall(x, y);
                item.draw(ctx);
                balls.push(item);
                return;
            }
            
            if(rand >= 0.25 && rand < 0.5)
            {
                var item = new TPackMan(x, y);
                item.draw(ctx);
                balls.push(item);
                return;
            }
            
            if(rand >= 0.5 && rand < 0.75)
            {
                var item = new TRect(x,y);
                item.draw(ctx);
                rects.push(item);
                return;
            }
            
            var item = new TRectBall(x, y);
            
            item.draw(ctx);
            rects.push(item);
            return;
        }

        function Dist(x1, y1, x2, y2)
        {
            return Math.sqrt(
                (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
        }

        function checkIntersectionBall(a, b)
        {
            var d = Dist(a.posX, a.posY, b.posX, b.posY);
            
            if (d <= (a.len + b.len)) return true;
            
            return false;
        }

        function checkIntersectionRect(a, b) //
        {
            var d = Dist(a.posX, a.posY, b.posX, b.posY);
            var distRect = Dist(
                a.posX + a.len, a.posY + a.len, a.posX, a.posY);
            
            if (d <= distRect &&
                a.posX <= b.posX &&
                a.posX + a.len >= b.posX &&
                a.posY <= b.posY &&
                a.posY + a.len >= b.posY)
            {
                return true;
            }
            
            if
            (
                ((a.posY >= b.posY && a.posY <= b.posY + b.len) ||
                 (a.posY + a.len >= b.posY && a.posY + a.len <= b.posY + b.len))
                &&
                ((a.posX >= b.posX && a.posX <= b.posX + b.len) ||
                 (a.posX + a.len >= b.posX) && a.posX + a.len <= b.posX + b.len)
            )
            {
                return true;
            }
            
            return false;
        }

        function clearCollision(arr, i, func)
        {
            for (var j = 0; j < arr.length; j++)
            {
                if (j == i) continue;
                
                if (func(arr[i], arr[j])) 
                {
                    arr.splice(j, 1);
                    arr.splice((i < j) ? i : i - 1, 1);
                    break;
                }
            }
        }

        function checkRectBallIntersec()
        {
            for (var i = 0; i < balls.length; i++)
            {
                for (var j = 0; j < rects.length; j++)
                {
                    if (
                        (Dist
                         (balls[i].posX, balls[i].posY, rects[j].posX, rects[j].posY) <= balls[i].len
                        ) 
                        ||
                        (Dist
                         (balls[i].posX, balls[i].posY, rects[j].posX + rects[j].len, rects[j].posY) <= balls[i].len
                        ) 
                        || 
                        (Dist
                         (balls[i].posX, balls[i].posY, rects[j].posX, rects[j].posY + rects[j].len) <= balls[i].len
                        ) 
                        || 
                        (Dist
                         (balls[i].posX, balls[i].posY, rects[j].posX + rects[j].len, rects[j].posY + rects[j].len) <= balls[i].len
                        ) 
                        || 
                        (
                            Math.abs(balls[i].posY - rects[j].posY) <= balls[i].len 
                            &&
                            balls[i].posX >= rects[j].posX 
                            && 
                            balls[i].posX <= rects[j].posX + rects[j].len
                        ) 
                        ||
                        (
                            Math.abs(balls[i].posX - rects[j].posX) <= balls[i].len 
                            &&
                            balls[i].posY >= rects[j].posY 
                            &&
                            balls[i].posY <= rects[j].posY + rects[j].len
                        )
                    )
                    {
                        rects.splice(j,1);
                        j--;
                        balls.splice(i,1);
                        i--;
                        
                        if(i < 0) i=0;
                        
                        if(balls.lenght <= 0)
                        {
                            i=balls.length + 1000;
                            j=rects.lenght + 1000;
                        }
                    }
                }
            }
            
        }

        function reDraw(arr)
        {
            for (var i = 0; i < arr.length; i++)
            {
                arr[i].draw(ctx);
            }
        }

        function moveFigureRand(func, arr) 
        {
            drawBack(ctx, '#202020', '#aaa', canvas.width, canvas.height);
            
            for (var i = 0; i < arr.length; i++) 
            {
                if (arr[i].len + lenInc >= SizeLimit) 
                {
                    arr.splice(i, 1);
                    i--;
                    continue;
                }

                arr[i].len += lenInc;
                arr[i].posX =
                    arr[i].posX + ((Math.random() + 1) + lenInc + arr[i].correction) * arr[i].directionX;
                
                arr[i].posY =
                    arr[i].posY + ((Math.random() + 1) + lenInc + arr[i].correction) * arr[i].directionY;

                if (arr[i].posX + arr[i].len >= canvas.width)
                {
                    arr[i].directionX *= (-1);
                    arr[i].posX -= arr[i].posX + arr[i].len - canvas.width;
                }
                
                if (arr[i].posX - arr[i].len <= 0) 
                {
                    arr[i].directionX *= (-1);
                    arr[i].posX += arr[i].len - arr[i].posX;
                }
                
                if (arr[i].posY + arr[i].len >= canvas.height) 
                {
                    arr[i].directionY *= (-1);
                    arr[i].posY -= arr[i].posY + arr[i].len - canvas.height;
                }
                
                if (arr[i].posY - arr[i].len <= 0) 
                {
                    arr[i].directionY *= (-1);
                    arr[i].posY += arr[i].len - arr[i].posY;
                }
                
                clearCollision(arr, i, func);
            }
            
        }

        function moveVertical(func, arr, dir) 
        {
            drawBack(ctx, '#202020', '#aaa', canvas.width, canvas.height);
            
            for (var i = 0; i < arr.length; i++) 
            {
                if (arr[i].len + lenInc >= SizeLimit) 
                {
                    arr.splice(i, 1);
                    i--;
                    continue;
                }

                arr[i].len += lenInc;
                arr[i].posY -= (Math.random() + 1 + lenInc + arr[i].correction) * dir;

                if (arr[i].posY <= 0)
                {
                    arr[i].posY = canvas.height;
                }
                
                clearCollision(arr, i, func);
            }
        }

        function moveHorizontal(func, arr, dir) 
        {
            drawBack(ctx, '#202020', '#aaa', canvas.width, canvas.height);
            
            for (var i = 0; i < arr.length; i++) 
            {
                if (arr[i].len + lenInc >= SizeLimit) 
                {
                    arr.splice(i, 1);
                    i--;
                    continue;
                }

                arr[i].len += lenInc;
                arr[i].posX -= (Math.random() + 1 + lenInc + arr[i].correction) * dir;

                if (arr[i].posX <= 0)
                {
                    arr[i].posX = canvas.width;
                }
                
                clearCollision(arr, i, func);
            }
        }
        
        function moving(dir, plane)
        {
            switch(dir)
            {
                case  (1):
                case (-1):
                    if (plane == 1)
                    {
                        moveVertical(checkIntersectionRect, rects, dir);
                        moveVertical(checkIntersectionBall, balls, dir);
                    } 
                    else 
                    {
                        moveHorizontal(checkIntersectionRect, rects, dir);
                        moveHorizontal(checkIntersectionBall, balls, dir);
                    }
                    
                    checkRectBallIntersec();
                    break;
                case 0:
                    moveFigureRand(checkIntersectionRect, rects);
                    moveFigureRand(checkIntersectionBall, balls);
                    checkRectBallIntersec();
                    break;
            }
            
            reDraw(rects);
            reDraw(balls);
        }
        
        function move(type) 
        {
            isStop = false;
            prevType = type;
            clearInterval(idTimer);
            
            switch (type) 
            {
                case 1:
                    idTimer = setInterval('moving(0, 0);', accelerate);
                    break;
                case 2:
                    idTimer = setInterval('moving(1, 1);', accelerate);
                    break;
                case 3:
                    idTimer = setInterval('moving(1, 0);', accelerate);
                    break;
                case 4:
                    idTimer = setInterval('moving(-1, 0);', accelerate);
                    break;
                case 5:
                    idTimer = setInterval('moving(-1, 1);', accelerate);
                    break;
            }
        }

        function changeSpeedLimit()
        {
            var tmp = document.id('SpeedCorrect');
            accelerate = tmp.value;
            move(prevType);
        }
        
        function changeSizeLimit()
        {
            var tmp = document.id('SizeCorrect');
            SizeLimit = tmp.value;
        }
        
        function changeFiguresLimit()
        {
            var tmp = document.id('FiguresCorrect');
            FiguresLimit = tmp.value;
        }
    </script>
</head>

<body onload="init()" onresize="init()">
    <canvas id="canvas" width="1300" height="600" onclick="goInput(event);"></canvas>
    <form>
        <p><b>Game modes:</b>
            <input type="button" value="Random" onclick="move(1)">
            <input type="button" value="Up" onclick="move(2)">
            <input type="button" value="Left" onclick="move(3)">
            <input type="button" value="Right" onclick="move(4)">
            <input type="button" value="Down" onclick="move(5)">
            <input type="button" value="Generate" onclick="init()">
            <input type="button" value="Stop" onclick="clearInterval(idTimer); isStop = true;">
        </p>
        
        <p><i><b>Please note:</b> figures move <b>really</b> slow if speed is above 1000</i></p>
        <input id="SpeedCorrect" type="number" onchange="changeSpeedLimit()" placeholder="Move speed">
        
        <p><i><b>Please note:</b> less than 50 sucks</i></p>
        <input id="SizeCorrect" type="number" onchange="changeSizeLimit()" placeholder="Max size">
        
        <p><i><b>Please note:</b> page can freeze with numbers above 1000</i></p>
        <input id="FiguresCorrect" type="number" onchange="changeFiguresLimit()" placeholder="Generated figures num">
    </form>
</body>
