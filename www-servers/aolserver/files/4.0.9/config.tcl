#
# The contents of this file are subject to the AOLserver Public License
# Version 1.1 (the "License"); you may not use this file except in
# compliance with the License. You may obtain a copy of the License at
# http://aolserver.com/.
#
# Software distributed under the License is distributed on an "AS IS"
# basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
# the License for the specific language governing rights and limitations
# under the License.
#
# The Original Code is AOLserver Code and related documentation
# distributed by AOL.
# 
# The Initial Developer of the Original Code is America Online,
# Inc. Portions created by AOL are Copyright (C) 1999 America Online,
# Inc. All Rights Reserved.
#
# Alternatively, the contents of this file may be used under the terms
# of the GNU General Public License (the "GPL"), in which case the
# provisions of GPL are applicable instead of those above.  If you wish
# to allow use of your version of this file only under the terms of the
# GPL and not to allow others to use your version of this file under the
# License, indicate your decision by deleting the provisions above and
# replace them with the notice and other provisions required by the GPL.
# If you do not delete the provisions above, a recipient may use your
# version of this file under either the License or the GPL.
# 
#
# $Header: /var/cvsroot/gentoo-x86/www-servers/aolserver/files/4.0.9/config.tcl,v 1.1 2005/01/05 19:49:09 port001 Exp $
#
 
#
# Set some Tcl variables that are commonly used throughout this file.
#

# The hostname and address should be set to actual values.
set hostname               localhost
set address                127.0.0.1

set servername             "aolserver"
set serverdesc             "Gentoo Linux AOLserver"

set httpport               8000
set httpsport              8443

set directoryfile          index.adp,index.html,index.htm

set homedir                /usr/lib/aolserver
set bindir                 ${homedir}/bin
set logdir                 /var/log/aolserver
set piddir                 /var/run/aolserver

set serverroot             /var/aolserver
set pageroot               /var/www/ns-${hostname}

set debug                  false


###################
# Modules to load
#
ns_section "ns/server/${servername}/modules"

    ##################
    # Standard AOLserver modules
    ns_param nssock ${bindir}/nssock.so
    ns_param nslog ${bindir}/nslog.so
    #ns_param nscgi ${bindir}/nscgi.so
    #ns_param nsperm ${bindir}/nsperm.so
    #ns_param nscp ${bindir}/nscp.so

    ##################
    # The modules below are not installed by default. Some of them exist as
    # separate ebuilds.
    #ns_param nssha1 ${bindir}/nssha1.so
    #ns_param nscache ${bindir}/nscache.so

    # URL rewriting module
    #ns_param nsrewrite ${bindir}/nsrewrite.so

    # Allow SSL connections
    #ns_param nsopenssl ${bindir}/nsopenssl.so
    
    # Enable free text search
    #ns_param nsfts ${bindir}/nsfts.so

    # Allow PAM authentication
    #ns_param nspam ${bindir}/nspam.so
  
    # Allow LDAP authentication
    #ns_param nsldap ${bindir}/nsldap.so


###################################################################### 
#
# AOLserver Parameters
#
###################################################################### 

#
# Global server parameters
#
ns_section "ns/parameters"
  ns_param   home            $homedir
  ns_param   logroll         on
  ns_param   serverlog       ${logdir}/error.log
  ns_param   maxbackup       5
  ns_param   pidfile         ${piddir}/${servername}.pid
  ns_param   maxkeepalive    0
  ns_param   debug           $debug

  # I18N Parameters
  # Automatic adjustment of response content-type header to include charset
  #ns_param   HackContentType true

  # Default output charset.  When none specified, no character encoding of 
  # output is performed.
  ns_param   OutputCharset   iso8859-1

  # Default Charset for Url Encode/Decode. When none specified, no character 
  # set encoding is performed.
  ns_param   URLCharset      iso8859-1

  # This parameter supports output encoding arbitration.
  #ns_param  PreferredCharsets { utf-8 iso8859-1 }

#
# Thread library (nsthread) parameters
#
ns_section "ns/threads"
  # Per-thread stack size.
  ns_param   stacksize       [expr 512*1024]
  # Measure lock contention
  ns_param   mutexmeter      false

#
# MIME types.
#
#  Note: AOLserver already has an exhaustive list of MIME types, but in
#  case something is missing you can add it here.
ns_section "ns/mimetypes"
  ns_param   default         "*/*"     ;# MIME type for unknown extension.
  ns_param   noextension     "*/*"     ;# MIME type for missing extension.
  ns_param   .pcd            image/x-photo-cd
  ns_param   .prc            application/x-pilot
  ns_param   .xls            application/vnd.ms-excel
  ns_param   .doc            application/vnd.ms-word

  # I18N Mime-types; define content-type header values
  #                  to be mapped from these file-types.
  #                  Note that you can map file-types of adp files to control
  #                  the output encoding through mime-type specificaion.
  #                  Remember to add an adp mapping for that extension.
  ns_param   .adp            "text/html; charset=iso-8859-1"
  ns_param   .u_adp          "text/html; charset=UTF-8"
  ns_param   .gb_adp         "text/html; charset=GB2312"
  ns_param   .sjis_html      "text/html; charset=shift_jis"
  ns_param   .sjis_adp       "text/html; charset=shift_jis"
  ns_param   .gb_html        "text/html; charset=GB2312"

#
# I18N File-type to Encoding mappings
#
ns_section "ns/encodings"
  ns_param   .utf_html       "utf-8"
  ns_param   .sjis_html      "shiftjis"
  ns_param   .gb_html        "gb2312"
  ns_param   .big5_html      "big5"
  ns_param   .euc-cn_html    "euc-cn"
  # Note: you will need to include file-type to encoding mappings
  #       for ANY source files that are to be used, to allow the
  #       server to handle them properly.  E.g., the following
  #       asserts that the GB-producing .adp files are themselves
  #       encoded in GB2312 (this is not simply assumed).
  ns_param   .gb_adp         "gb2312"



###################################################################### 
#
# Server-level configuration
#
#  There is only one server in AOLserver, but this is helpful when multiple
#  servers share the same configuration file.  This file assumes that only
#  one server is in use so it is set at the top in the "server" Tcl variable.
#  Other host-specific values are set up above as Tcl variables, too.
#
###################################################################### 

ns_section "ns/servers"
  ns_param   $servername     $serverdesc


#
# Server parameters
#
ns_section "ns/server/${servername}"
  ns_param   directoryfile   $directoryfile
  ns_param   pageroot        $pageroot
  ns_param   enabletclpages  true     ;# Parse *.tcl files in pageroot.

  # Server-level I18N Parameters can be specified here, to override
  # the global ones for this server.  These are:
  #     HackContentType
  #     OutputCharset
  #     URLCharset
  # See the global parameter I18N section for a description of these.

  # Scaling and Tuning Options
  #
  #  Note: These values aren't necessarily the defaults.
  #ns_param   connsperthread  0         ;# Normally there's one conn per thread
  #ns_param   flushcontent    false     ;# Flush all data before returning
  #ns_param   maxconnections  100       ;# Max connections to put on queue
  #ns_param   maxdropped      0         ;# Shut down if dropping too many conns
  #ns_param   maxthreads      20        ;# Tune this to scale your server
  #ns_param   minthreads      0         ;# Tune this to scale your server
  #ns_param   threadtimeout   120       ;# Idle threads die at this rate

  # Special HTTP pages
  #ns_param   NotFoundResponse             "/global/file-not-found.html"
  #ns_param   ServerBusyResponse           "/global/busy.html"
  #ns_param   ServerInternalErrorResponse  "/global/error.html"


# Fast path configuration is used to configure options used for serving 
# static content, and also provides options to automatically display 
# directory listings.
ns_section "ns/server/${servername}/fastpath"
  # Enable cache for normal URLs.
  #ns_param cache                          false
  # Size of fast path cache.
  #ns_param cachemaxsize                   5120000
  # Largest file size allowed in cache.
  #ns_param cachemaxentry                  [expr {$cachemaxsize / 10}]
  # Use mmap() for cache.
  #ns_param mmap                           false
  # Directory listing style. Can be "fancy" or "simple". 
  #ns_param directorylisting               fancy
  # Directory index/default page to look for.
  #ns_param directoryfile                  $directoryfile
  # Name of Tcl proc to use to display directory listings.
  #ns_param directoryproc                  _ns_dirlist
  # Name of ADP page to use to display directory listings.
  #ns_param directoryadp                   example.adp

#
# ADP (AOLserver Dynamic Page) configuration
#
ns_section "ns/server/${servername}/adp"
  # Extensions to parse as ADP's.
  ns_param   map             "/*.adp"
  ns_param   map             "/*.u_adp"
  ns_param   map             "/*.gb_adp"
  ns_param   map             "/*.sjis_adp"
  # Any extension can be mapped.
  #ns_param   map             "/*.html"

  # Set "Expires: now" on all ADP's.
  ns_param   enableexpire    false
  # Allow Tclpro debugging with "?debug".
  ns_param   enabledebug     false

  # ADP special pages
  #ns_param   errorpage      ${pageroot}/errorpage.adp

# 
# Tcl Configuration 
# 
ns_section "ns/server/${servername}/tcl"
  # Enable server specific tcl libraries
  #ns_param   library        ${serverroot}/tcl
  #ns_param   autoclose      on 
  #ns_param   debug          $debug
 
###################################################################### 
#
# Module specific configuration
#
###################################################################### 

#
# Socket driver module (HTTP)  -- nssock
#
ns_section "ns/server/${servername}/module/nssock"
  ns_param   port                 $httpport
  ns_param   hostname             $hostname
  ns_param   address              $address
  ns_param   timeout              120

#
# Access log -- nslog
#
ns_section "ns/server/${servername}/module/nslog"
  ns_param   rolllog              true
  # Roll log on SIGHUP.
  ns_param   rollonsignal         true
  ns_param   rollday              *
  ns_param   rollhour             0
  ns_param   rollfmt              %Y-%m-%d-%H:%M
  # Max number to keep around when rolling.
  ns_param   maxbackup            5
  ns_param   file                 ${logdir}/${servername}.log
  ns_param   enablehostnamelookup false
  ns_param   logcombined          true
  #ns_param   logrefer             false
  #ns_param   loguseragent         false

#
# Socket driver module (HTTPS) -- nsopenssl
#
#ns_section "ns/server/${servername}/module/nsopenssl"
#set ciphersuite "ALL:!ADH:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP"
  # Typically where you store your certificates
  #ns_param ModuleDir                       ${serverroot}/etc/certs
  #ns_param RandomFile                      /dev/random
  #ns_param SeedBytes                       1024

  # NSD-driven connections:
  #ns_param ServerPort                      $httpsport
  #ns_param ServerHostname                  $hostname
  #ns_param ServerAddress                   $address
  #ns_param ServerCertFile                  certfile.pem
  #ns_param ServerKeyFile                   keyfile.pem
  #ns_param ServerProtocols                 "SSLv2, SSLv3, TLSv1"
  #ns_param ServerCipherSuite               $ciphersuite 
  #ns_param ServerSessionCache              false
  #ns_param ServerSessionCacheID            1
  #ns_param ServerSessionCacheSize          512
  #ns_param ServerSessionCacheTimeout       300
  #ns_param ServerPeerVerify                true
  #ns_param ServerPeerVerifyDepth           3
  #ns_param ServerCADir                     ca
  #ns_param ServerCAFile                    ca.pem
  #ns_param ServerTrace                     false

  # For listening and accepting SSL connections via Tcl/C API:
  #ns_param SockServerCertFile              certfile.pem
  #ns_param SockServerKeyFile               keyfile.pem
  #ns_param SockServerProtocols             "SSLv2, SSLv3, TLSv1"
  #ns_param SockServerCipherSuite           $ciphersuite 
  #ns_param SockServerSessionCache          false
  #ns_param SockServerSessionCacheID        2
  #ns_param SockServerSessionCacheSize      512
  #ns_param SockServerSessionCacheTimeout   300
  #ns_param SockServerPeerVerify            true
  #ns_param SockServerPeerVerifyDepth       3
  #ns_param SockServerCADir                 internal_ca
  #ns_param SockServerCAFile                internal_ca.pem
  #ns_param SockServerTrace                 false

  # Outgoing SSL connections
  #ns_param SockClientCertFile              certfile.pem
  #ns_param SockClientKeyFile               keyfile.pem
  #ns_param SockClientProtocols             "SSLv2, SSLv3, TLSv1"
  #ns_param SockClientCipherSuite           $ciphersuite
  #ns_param SockClientSessionCache          false
  #ns_param SockClientSessionCacheID        3
  #ns_param SockClientSessionCacheSize      512
  #ns_param SockClientSessionCacheTimeout   300
  #ns_param SockClientPeerVerify            true
  #ns_param SockServerPeerVerifyDepth       3
  #ns_param SockClientCADir                 ca
  #ns_param SockClientCAFile                ca.pem
  #ns_param SockClientTrace                 false


#
# Server control port module -- nscp
#
#ns_section "ns/server/${servername}/module/nscp"
  #ns_param address 127.0.0.1        
  #ns_param port 9999
  #ns_param echopassword 1
  #ns_param cpcmdlogging 1

#ns_section "ns/server/${servername}/module/nscp/users"
  # You can use the ns_crypt Tcl command to generate an encrypted
  # password. The ns_crypt command uses the same algorithm as the 
  # Unix crypt(3) command. You could also use passwords from the
  # /etc/passwd file.
  #
  # Users should be listed in the following format:
  #   <user>:<encryptedPassword>:
  #
  # The configuration example below adds the user "nsadmin" with a 
  # password of "x".
  #ns_param user "nsadmin:t2GqvvaiIUbF2:"

#
# CGI interface -- nscgi
#
#  WARNING: These directories must not live under pageroot.
#
ns_section "ns/server/${servername}/module/nscgi"
  #ns_param   map "GET  /cgi ${serverroot}/cgi"  ;# CGI script file dir (GET).
  #ns_param   map "POST /cgi ${serverroot}/cgi"  ;# CGI script file dir (POST).


#
# Example: Host headers based virtual servers.
#
# To enable:
#
# 1. Load comm driver(s) globally.
# 2. Configure drivers as in a virtual server.
# 3. Add a "servers" section to map virtual servers to Host headers.
#
#ns_section ns/modules
#ns_section nssock nssock.so
#
#ns_section ns/module/nssock
#ns_param   port            $httpport
#ns_param   hostname        $hostname
#ns_param   address         $address
# 
#ns_section ns/module/nssock/servers
#ns_param server1 $hostname:$httpport
#
#ns_section /ns/servers/server1
#ns_param pageroot /var/www/$hostname/aolserver/www

#
# Example:  Multiple connection thread pools.
#
# To enable:
# 
# 1. Define one or more thread pools.
# 2. Configure pools as with the default server pool.
# 3. Map method/URL combinations to the pools
# 
# All unmapped method/URL's will go to the default server pool.
# 
#ns_section ns/server/server1/pools
#ns_section slow "Slow requests here."
#ns_section fast "Fast requests here." 
#
#ns_section ns/server/server1/pool/slow
#ns_param map {POST /slowupload.adp}
#ns_param maxconnections  100       ;# Max connections to put on queue
#ns_param maxdropped      0         ;# Shut down if dropping too many conns
#ns_param maxthreads      20        ;# Tune this to scale your server
#ns_param minthreads      0         ;# Tune this to scale your server
#ns_param threadtimeout   120       ;# Idle threads die at this rate
#
#ns_section ns/server/server1/pool/fast
#ns_param map {GET /faststuff.adp}
#ns_param maxthreads 10
#

#
# Example:  Web based stats interface.
#
# To enable:
#
# 1. Configure whether or not stats are enabled. (Optional: default = false)
# 2. Configure URL for statistics. (Optional: default = /_stats)
#
#    http://<host>:<port>/_stats
# 
# 3. Configure user. (Optional: default = aolserver)
# 4. Configure password. (Optional: default = stats)
#
# For added security it is recommended that configure your own
# URL, user, and password instead of using the default values.
#
#ns_section ns/server/stats
#    ns_param enabled 1
#    ns_param url /aolserver/stats
#    ns_param user aolserver
#    ns_param password 23dfs!d
# 
