(:
 : Copyright 2010 Mark Logic Corporation.  All Rights Reserved.
 :)
xquery version "1.0-ml";
declare namespace ai="api-install";

try {
let $app         := xdmp:get-request-field("app")
let $name        := fn:substring-before($app, ":")
let $port        := fn:substring-after($app, ":")
let $noappserver := xdmp:get-request-field("noappserver")
let $nodb        := xdmp:get-request-field("nodb")
let $_           :=
  xdmp:log(fn:concat("Installing ", $name, " on port ", $port, 
    ". NoAppServer set to ", $noappserver, ". NoDB set to ", $nodb, "."))
let $args-name := (xs:QName("ai:name"), $name)
let $args-port := ($args-name, xs:QName("ai:port"), $port)
let $args-nodb := ($args-port, xs:QName("ai:nodb"), fn:boolean($nodb))
return ( 
    xdmp:invoke("hooks/install/precommit.xqy", $args-port),
    if ($nodb) then () else xdmp:invoke("create-forest.xqy", $args-name),
    if ($nodb) then () else xdmp:invoke("create-database.xqy", $args-name),
    if ($nodb) then () else xdmp:invoke("attach-forest.xqy", $args-name),
    if ($noappserver) then () else xdmp:invoke("create-http-server.xqy", $args-nodb),
    xdmp:invoke("hooks/install/incommit.xqy", $args-port),
    <div> Click 
      <a href="{fn:concat('http://localhost:', $port)}">here</a> to continue...
    </div> )
 } catch ($e) {
   <div> <h3>Error</h3>
     <div class="error-stack-trace"> { $e } </div>
   </div>
 }
