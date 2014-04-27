<html>
        <head>
                <title>SwiftServe Token Authentication</title>
        </head>
        <body>
		<a href="http://www.swiftserve.com"><img src="http://www.swiftserve.com/static/img/swiftserve_logo.png"></a>
                <form method="post" action="ss2_token.php">
                <h3>SwiftServe Token Authentication - URL Generator</h3>
                <h4>***Remove protocol and hostname from the URL***</h4>
		<i>Example</i>
		<br><i>URL: http://edge.swiftsg.swiftserve.com/vod/Pete/mp4:petevod/bbb_150.mp4/manifest.f4m</i>
		<br><i>Delivery URL: /vod/Pete/mp4:petevod/bbb_150.mp4/manifest.f4m</i>
                <br>Enter Delivery URL from SwiftServe:
                <input type="text" name="url" size="120"/>
                <h4>Mandatory fields</h4>The UTC time now(YmdHMS): 20140407075234
                <br>Enter Start Time(UTC):
                <input type="text" name="stime" size="25"/>
                <br>Enter End Time(UTC):
                <input type="text" name="etime" size="25"/>
                <br>Enter Secret:
                <input type="text" name="secret" size="50"/>
                <h4>Optional field</h4>
                Enter IP of user to enforce Token:
                <input type="text" name="ip" />
                <br><br><input type="submit" />
                </form>
        </body>
</html>