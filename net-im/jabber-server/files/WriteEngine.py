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

        if JUDData['extra_jud'] == 1:
               extra_jud_1 = """
        <service type="jud" jid=\"""" + JUDData['jid'] + """\" name=\"""" + JUDData['name'] + """\">
          <ns>jabber:iq:search</ns>
          <ns>jabber:iq:register</ns>
        </service>"""
               extra_jud_2 = """<service id="jud"> <host>jud.""" + GeneralData['domainname'] + """</host>
        <load><jud>./jud-0.4/jud.so</jud></load>
        <jud xmlns="jabber:config:jud">
        <vCard>
          <FN>User Directory on """ + GeneralData['domainname'] + """</FN>
          <DESC>This service provides a simple user directory service.</DESC>
          <URL>""" + GeneralData['vcard_url'] + """</URL>
        </vCard>
        </jud>
        </service>
        """
        else:
                extra_jud_1 = " "
                extra_jud_2 = " "

        if CONData['enable_con'] == 1:
               enable_con_1 = "\n<conference type=\"private\" jid=\"" + CONData['jid'] + "\" name=\"" + CONData['name'] + """\"/>"""
               enable_con_2 = "\n<service id=\"" + CONData['jid'] + "." + GeneralData['domainname'] + "\">" + """
        <load><conference>./conference-0.4/conference.so</conference></load>
          <conference xmlns="jabber:config:conference">
          <vCard>
          <FN>Conferencing Service</FN>
          <DESC>This service is for private chatrooms.</DESC>
          <URL>""" + GeneralData['vcard_url'] + """</URL>
          </vCard>
          <history>20</history>
          <notice>
          <join> has joined</join>
          <leave> has left</leave>
          <rename> is now known as </rename>
          </notice>
          </conference>
     </service>
     """

        else:
                enable_con_1 = " "
                enable_con_2 = " "


        if AIMData['enable_aim'] == 1:
               enable_aim_1 = """
        <service type="aim" jid=\"""" + AIMData['jid'] + """\" name=\"""" + AIMData['name'] + """\">
          <ns>jabber:iq:gateway</ns>
          <ns>jabber:iq:search</ns>
          <ns>jabber:iq:register</ns>
        </service>"""
               enable_aim_2 = "<service id=" + AIMData['jid'] + "." + GeneralData['domainname'] + """>
        <aimtrans xmlns='jabber:config:aimtrans'>
        <vCard>
          <FN>AIM Transport</FN>
          <DESC>The AIM Transport</DESC>
          <URL>""" + GeneralData['vcard_url'] + """</URL>
        </vCard>
        </aimtrans>
        <load>
          <aim_transport>./aim-transport-0.9.24c/src/aimtrans.so</aim_transport>
        </load>
        </service>
        """
        else:
                enable_aim_1 = " "
                enable_aim_2 = " "


        if ICQData['enable_icq'] == 1:
               enable_icq_1 = """
        <service type="icq" jid=\"""" + ICQData['jid'] + """\" name=\"""" + ICQData['name'] + """\">
          <ns>jabber:iq:gateway</ns>
          <ns>jabber:iq:search</ns>
          <ns>jabber:iq:register</ns>
        </service>"""
               enable_icq_2 = "<service id=" + ICQData['jid'] + "." + GeneralData['domainname'] + """>
        <!-- <aimtrans xmlns='jabber:config:aimtrans'> ?? -->
        <icqtrans xmlns="jabber:config:icqtrans">
        <instructions>Please enter your ICQ number (in the "username" field),
        nickname, and password. Leave the "username" field blank
        to create a new ICQ number.</instructions>
        <search>Search for ICQ users</search>
        <vCard>
          <FN>ICQ Transport</FN>
          <DESC>The ICQ Transport</DESC>
          <URL>""" + GeneralData['vcard_url'] + """</URL>
        </vCard>
        <prime>37</prime>
        <ports>
        <min>2000</min>
        <max>3000</max>
        </ports>
        </icqtrans>
        <load>
          <icqtrans>./aim-transport-0.9.24c/src/aimtrans.so</icqtrans>
        </load>
        </service>
        """
        else:
                enable_icq_1 = " "
                enable_icq_2 = " "


        f = open('jabber.xml', 'w')
        f.write("""
<jabber>
   <!-- This Jabber Server Configuration File is built with Dr. JabServ,
        the Jabber Config Tool... -->

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


      <browse>

        <service type="jud" jid="users.jabber.org" name="Jabber User Directory">
          <ns>jabber:iq:search</ns>
          <ns>jabber:iq:register</ns>
        </service>
        """ + extra_jud_1 + enable_con_1 + enable_aim_1 + enable_icq_1 + """

      </browse>


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

  """ + extra_jud_2 + enable_con_2 + enable_aim_2 + enable_icq_2 + """

  <io>

    <rate points="5" time="25"/>

  </io>

  <pidfile>./jabber.pid</pidfile>


</jabber>""")





        print " "
        print "Jabber Server Configuration File Written.... Exiting...."
        print " "
