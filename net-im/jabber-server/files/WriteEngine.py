#!/usr/bin/env python

##################################################################
##                                                              ##
## Written By Bart Verwilst <verwilst@gentoo.org>               ##
## For additions and bugfixes, Please consult the author!       ##
##                                                              ##
##################################################################
from SetupEngine import *

def WriteConfig():
        if GeneralData['admin_notif'] == 0:
                admin_notif = "<register notify=\"no\">"
        else:
                admin_notif = "<register notify=\"yes\">"

        if GeneralData['new_welcome'] == 0:
                new_welcome = " "
        else:
                new_welcome = """
      <welcome>
        <subject>""" + GeneralData['new_welcome_subject'] + """</subject>
        <body>""" + GeneralData['new_welcome_body'] + """</body>
      </welcome>
      """

        if GeneralData['vcard2jud'] == 0:
                vcard2jud = " "
        else:
                vcard2jud = """
     <vcard2jud/>"""


        f = open('jabber.xml', 'w')
        f.write("""
<jabber>

  <service id="sessions">

    <host><jabberd:cmdline flag="h">""" + GeneralData['domainname'] + """</jabberd:cmdline></host>

    <jsm xmlns="jabber:config:jsm">

      <filter>
          <default/>
          <max_size>100</max_size>
          <allow>
              <conditions>
                  <ns/>
                  <unavailable/>
                  <from/>
                  <resource/>
                  <subject/>
                  <body/>
                  <show/>
                  <type/>
                  <roster/>
                  <group/>
              </conditions>
              <actions>
                  <error/>
                  <offline/>
                  <forward/>
                  <reply/>
                  <continue/>
                  <settype/>
              </actions>
          </allow>
      </filter>

      <vCard>
        <FN>""" + GeneralData['vcard_subject'] + """</FN>
        <DESC>""" + GeneralData['vcard_desc'] + """</DESC>
        <URL>""" + GeneralData['vcard_url'] + """</URL>
      </vCard>

      """ + admin_notif + """
        <instructions>Choose a username and password to register with this server.</instructions>
        <name/>
        <email/>
      </register>

      """ + new_welcome + vcard2jud + """
      </jsm>

    <load main="jsm">
      <jsm>./jsm/jsm.so</jsm>
      <mod_echo>./jsm/jsm.so</mod_echo>
      <mod_roster>./jsm/jsm.so</mod_roster>
      <mod_time>./jsm/jsm.so</mod_time>
      <mod_vcard>./jsm/jsm.so</mod_vcard>
      <mod_last>./jsm/jsm.so</mod_last>
      <mod_version>./jsm/jsm.so</mod_version>
      <mod_announce>./jsm/jsm.so</mod_announce>
      <mod_agents>./jsm/jsm.so</mod_agents>
      <mod_browse>./jsm/jsm.so</mod_browse>
      <mod_admin>./jsm/jsm.so</mod_admin>
      <mod_filter>./jsm/jsm.so</mod_filter>
      <mod_offline>./jsm/jsm.so</mod_offline>
      <mod_presence>./jsm/jsm.so</mod_presence>
      <mod_auth_plain>./jsm/jsm.so</mod_auth_plain>
      <mod_auth_digest>./jsm/jsm.so</mod_auth_digest>
      <mod_auth_0k>./jsm/jsm.so</mod_auth_0k>
      <mod_log>./jsm/jsm.so</mod_log>
      <mod_register>./jsm/jsm.so</mod_register>
      <mod_xml>./jsm/jsm.so</mod_xml>
    </load>

  </service>

  <xdb id="xdb">
    <host/>
    <load>
      <xdb_file>./xdb_file/xdb_file.so</xdb_file>
    </load>
    <xdb_file xmlns="jabber:config:xdb_file">
      <spool><jabberd:cmdline flag='s'>./spool</jabberd:cmdline></spool>
    </xdb_file>
  </xdb>

  <service id="c2s">
    <load>
      <pthsock_client>./pthsock/pthsock_client.so</pthsock_client>
    </load>
    <pthcsock xmlns='jabber:config:pth-csock'>
      <authtime/>
      <karma>
        <init>10</init>
        <max>10</max>
        <inc>1</inc>
        <dec>1</dec>
        <penalty>-6</penalty>
        <restore>10</restore>
      </karma>

      <ip port="5222"/>

    </pthcsock>
  </service>

  <log id='elogger'>
    <host/>
    <logtype/>
    <format>%d: [%t] (%h): %s</format>
    <file>error.log</file>
    <stderr/>
  </log>

  <log id='rlogger'>
    <host/>
    <logtype>record</logtype>
    <format>%d %h %s</format>
    <file>record.log</file>
  </log>

  <service id="dnsrv">
    <host/>
    <load>
      <dnsrv>./dnsrv/dnsrv.so</dnsrv>
    </load>
    <dnsrv xmlns="jabber:config:dnsrv">
    	<resend service="_jabber._tcp">s2s</resend> <!-- for supporting SRV records -->
    	<resend>s2s</resend>
    </dnsrv>
  </service>

  <service id="s2s">
    <load>
      <dialback>./dialback/dialback.so</dialback>
    </load>
    <dialback xmlns='jabber:config:dialback'>
      <legacy/>
      <ip port="5269"/>
      <karma>
        <init>50</init>
        <max>50</max>
        <inc>4</inc>
        <dec>1</dec>
        <penalty>-5</penalty>
        <restore>50</restore>
      </karma>
    </dialback>
  </service>

  <io>

    <rate points="5" time="25"/>

  </io>

  <pidfile>./jabber.pid</pidfile>


</jabber>""")





        print " "
        print "Jabber Server Configuration File Written.... Exiting...."
        print " "
