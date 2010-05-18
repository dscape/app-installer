(:
 : Copyright 2010 Mark Logic Corporation.  All Rights Reserved.
 :)
xquery version "1.0-ml";

let $doctype := '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
let $html :=
    <html>
        <head>
            <title>API Application Setup</title>
            <script language="javascript" src="js/prototype.js" type="text/javascript">{" "}</script>
            <script type="text/javascript" language="javascript">
                //<![CDATA[
                    function install() {
                        var name = document.getElementById('name').value;
                        var port = document.getElementById('port').value;
                        
                        var url = '/api-installer/api-setup-run.xqy?app=' + name + ':' + port;
                        
                        new Ajax.Updater('results', '/api-installer/get-spinner.xqy', {asynchronous:true});
                        new Ajax.Updater('results', url, {asynchronous:true});
                    }
                //]]>
            </script> 
        </head>
        <body>
            <div style="font-weight:bold; font-size: 120%; text-align:center; padding: 20px;">API Search Install and Setup</div>
            <div>
                <span>Name: </span>
                <input type="textbox" id="name" />
                <span>Port: </span>
                <input type="textbox" id="port" />
                <input type="submit" value="Install" onClick="install()"/>
                <div id="results" style="padding: 20px; border: 1px solid #DDD; width: 500px; font-style: italic; margin-top: 20px;">{"<Current Progress>"}</div>
            </div>
        </body>
    </html>

return 
    (
    xdmp:set-response-content-type("text/html; charset=utf-8"), 
    $doctype, 
    $html
    )

