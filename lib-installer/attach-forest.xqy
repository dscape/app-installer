(:
 : Copyright 2010 Mark Logic Corporation.  All Rights Reserved.
 :)

xquery version "1.0-ml";
import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";

declare namespace ai="api-install";
declare variable $ai:name as xs:string external;

let $config := admin:database-attach-forest(
  admin:get-configuration(), xdmp:database($ai:name), xdmp:forest($ai:name))
return ( admin:save-configuration($config),
         <div class="message">
           A Database and Forest called {$ai:name} attached together successfully
         </div> )
