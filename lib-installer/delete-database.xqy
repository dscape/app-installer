(:
 : Copyright 2010 Mark Logic Corporation.  All Rights Reserved.
 :)

xquery version "1.0-ml";
import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";

declare namespace ai="api-install";
declare variable $ai:name as xs:string external;

try {
  let $config := admin:get-configuration()
  let $config :=  admin:database-delete($config, xdmp:database($ai:name))
  return admin:save-configuration($config)
 } catch ($e) {
   <div class="error-delete-database">
     <h3>Error</h3>
     <div class="error-stack-trace"> { $e } </div>
   </div>
 }
