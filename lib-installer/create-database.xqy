(:
 : Copyright 2010 Mark Logic Corporation.  All Rights Reserved.
 :)

xquery version "1.0-ml";
import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";

declare namespace ai="api-install";
declare variable $ai:name as xs:string external;

let $config := admin:database-create(admin:get-configuration(), $ai:name, xdmp:database("Security"), xdmp:database("Schemas"))
return
    (
    admin:save-configuration($config)
    ,
    <div class="message">A Database called {$ai:name} created successfully</div>
    )
