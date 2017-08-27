<?php

$config = file_get_contents('config.xml');

$config = str_replace('<platform name="ios">','<platform name="ios">
    <config-file target="*-Info.plist" parent="ITSAppUsesNonExemptEncryption">
      <false/>
    </config-file>
    <config-file target="*-Info.plist" parent="UINewsstandApp">
      <false/>
    </config-file>
    <config-file parent="NSAppTransportSecurity" target="*-Info.plist">
      <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true />
        <key>NSExceptionDomains</key>
        <dict>
          <key>play2pay.me</key>
          <true />
          <key>fbcdn.net</key>
          <dict>
            <key>NSIncludesSubdomains</key>
            <true />
            <key>NSExceptionRequiresForwardSecrecy</key>
            <false />
          </dict>
          <key>facebook.com</key>
          <dict>
            <key>NSIncludesSubdomains</key>
            <true />
            <key>NSExceptionRequiresForwardSecrecy</key>
            <false />
          </dict>
          <key>akamaihd.net</key>
          <dict>
            <key>NSIncludesSubdomains</key>
            <true />
            <key>NSExceptionRequiresForwardSecrecy</key>
            <false />
          </dict>
        </dict>
      </dict>
    </config-file>
',$config);

file_put_contents('config.xml',$config);
