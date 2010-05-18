(:
 : Copyright 2010 Mark Logic Corporation.  All Rights Reserved.
 :)

xquery version "1.0-ml";
import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";

declare namespace ai="api-install";
declare variable $ai:name as xs:string external;
declare variable $ai:port as xs:string external;
declare variable $ai:nodb as xs:boolean external;

(: Apps/usr :)
let $config := admin:get-configuration()
let $db     := if ($ai:nodb) then "Documents" else $ai:name
let $groupid := admin:group-get-id($config, "Default")
let $new-config := admin:http-server-create($config, $groupid, $ai:name, 
  fn:concat("Apps/usr/",$ai:name), xs:unsignedLong($ai:port), 0, xdmp:database($db) )
return
    (
    admin:save-configuration($new-config)
     ,
    <div class="message">An HTTP Server called {$ai:name} with root {$ai:name} on port {$ai:port} created successfully</div>
    )
