(:
 : Copyright 2010 Mark Logic Corporation.  All Rights Reserved.
 :)

xquery version "1.0-ml";
declare namespace ai="api-install";

try {
  let $name        := xdmp:get-request-field("app")
  let $noappserver := xdmp:get-request-field("noappserver")
  return ( 
    xdmp:invoke("hooks/uninstall/precommit.xqy", (xs:QName("ai:name"), $name)),
    if ($noappserver) then () else xdmp:invoke("delete-http-server.xqy", (xs:QName("ai:name"), $name)),
    xdmp:invoke("detach-forest.xqy", (xs:QName("ai:name"), $name)),
    xdmp:invoke("delete-database.xqy", (xs:QName("ai:name"), $name)),
    xdmp:invoke("delete-forest.xqy", (xs:QName("ai:name"), $name)),
    xdmp:invoke("hooks/uninstall/incommit.xqy", (xs:QName("ai:name"), $name)),
    <div> Uninstall complete </div>)
 } catch ($e) {
   <div class="error-triggers">
     <h3>Error in your supplied triggers</h3>
     <div class="error-stack-trace"> { $e } </div>
   </div>
 }
