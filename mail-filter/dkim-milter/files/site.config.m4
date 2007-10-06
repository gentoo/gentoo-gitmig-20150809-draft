dnl Build options for dkim-milter package
dnl ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

define(`confCCOPTS', `@@confCCOPTS@@')
define(`confENVDEF', `@@confENVDEF@@')

dnl Any options you set here are applied to all subdirectories of this
dnl build.  Also, you may override or augment the defaults of any of the
dnl values described in devtools/README by setting your preferred values
dnl in this file.

dnl Debug binary 
dnl
dnl If you are encountering coredumps and want to be able to analyze them
dnl using something like "gdb", enable this next line by deleting the "dnl"
dnl at the front of it.
dnl define(`confOPTIMIZE', `-g')

dnl libar -- asynchronous resolver library
dnl
dnl If you want to use the asynchronous resolver library, enable this
dnl next line by deleting the "dnl" at the front of it.
define(`bld_USE_ARLIB', `true')
dnl 
dnl libar normally uses res_init() or res_ninit() to load the contents
dnl of resolv.conf for its use.  If neither of these work on your system
dnl in multi-threaded programs (e.g. OpenBSD 3.7 and later), then you
dnl may need to enable code that parses that file manually.  This will
dnl also be required if you've got any IPv6 addresses in /etc/resolv.conf.
dnl In that case, enable this next line by deleting the "dnl" at the front
dnl of it.
dnl APPENDDEF(`conf_libar_ENVDEF', `-DAR_RES_MANUAL')

dnl POPAUTH -- POP-before-SMTP authentication
dnl
dnl If you use any POP-before-SMTP authentication, dkim-filter can
dnl query that database to see if a client sending a message for signing
dnl is legitimate, enable this next line by deleting the "dnl" at the
dnl front of it.
dnl APPENDDEF(`conf_dkim_filter_ENVDEF', `-DPOPAUTH ')

dnl BerkeleyDB -- Berkeley DB ("Sleepycat") database
dnl 
dnl Several optional features in this package need the Berkeley DB library.
dnl These include: _FFR_QUERY_CACHE, _FFR_STATS, POPAUTH
dnl 
dnl Sometimes this is built into your libc, but perhaps not, or perhaps
dnl you have a newer version that you want to use.  If that's the case,
dnl edit the following lines as needed and enable the ones that apply
dnl by deleting "dnl" from the front of them:
dnl APPENDDEF(`confINCDIRS', `-I/usr/local/BerkeleyDB/include ')
dnl APPENDDEF(`confLIBDIRS', `-L/usr/local/BerkeleyDB/lib ')
dnl APPENDDEF(`confLIBS', `-ldb ')

dnl OpenSSL -- cryptography library
dnl
dnl DKIM requires several algorithms provided by this library.  You must
dnl have v0.9.8 or later for SHA256 support.  If necessary, enable these
dnl lines by deleting "dnl" from the front of them and edit paths as needed.
APPENDDEF(`confINCDIRS', `-I/usr/include/ssl ')
APPENDDEF(`confLIBDIRS', `-L/usr/lib ')

dnl TRE -- Approximate regular expression matching
dnl
dnl If you want to use the dkim_diffheaders() function, you also need
dnl to have the "tre" library and its header files installed.  If necessary,
dnl enable these lines by deleting "dnl" from the front of them and edit
dnl paths as needed.
dnl APPENDDEF(`confINCDIRS', `-I/usr/local/include ')
dnl APPENDDEF(`confLIBDIRS', `-L/usr/local/lib ')
APPENDDEF(`confLIBS', `-ltre ')

dnl Code For Future Release (FFRs):
dnl
dnl See the FEATURES file for descriptions of the features available
dnl as options.  Many of these are untested and/or undocumented, so use
dnl at your own risk.  To enable one, delete "dnl" from the front of its
dnl line.
dnl 
dnl APPENDDEF(`confENVDEF', `-D_FFR_ANTICIPATE_SENDMAIL_MUNGE ')
dnl APPENDDEF(`confENVDEF', `-D_FFR_CAPTURE_UNKNOWN_ERRORS ')
dnl APPENDDEF(`confENVDEF', `-D_FFR_DIFFHEADERS ')
dnl APPENDDEF(`confENVDEF', `-D_FFR_KEY_REUSE ')
dnl APPENDDEF(`confENVDEF', `-D_FFR_QUERY_CACHE ')
dnl APPENDDEF(`confENVDEF', `-D_FFR_REQUIRED_HEADERS ')
dnl APPENDDEF(`confENVDEF', `-D_FFR_SELECT_CANONICALIZATION ')
dnl APPENDDEF(`confENVDEF', `-D_FFR_SELECT_SIGN_HEADERS ')
dnl APPENDDEF(`confENVDEF', `-D_FFR_SET_REPLY ')
APPENDDEF(`confENVDEF', `-D_FFR_STATS ')
dnl APPENDDEF(`confENVDEF', `-D_FFR_VBR ')
dnl APPENDDEF(`confENVDEF', `-D_FFR_ZTAGS ')

dnl DomainKeys -- Yahoo DomainKeys verification support
dnl 
dnl If you also want to verify messages signed with DomainKeys, enable this
dnl line by deleting "dnl" from the front of it.  See also the README as it
dnl requires an additional library not included in this package.
dnl define(`bld_VERIFY_DOMAINKEYS', `true')

dnl libmilter -- Sendmail's milter library
dnl
dnl This must be in the search rules for your compile.  If necessary,
dnl adjust the paths below and enable the lines by deleting "dnl" from the
dnl front of them.
APPENDDEF(`bld_dkim_filter_INCDIRS', `-I/usr/include/libmilter')
APPENDDEF(`bld_dkim_filter_LIBDIRS', `-L/usr/lib')

dnl smfi_addheader() -- older versions of libmilter
dnl
dnl If you run a version of libmilter too old to have the smfi_insheader()
dnl primitive, you can enable this to have dkim-filter use smfi_addheader()
dnl instead.  It will still work, but it breaks the DKIM specification.
dnl To enable this, remove the "dnl" from the front of the line.
dnl APPENDDEF(`conf_dkim_filter_ENVDEF', `-DNO_SMFI_INSHEADER ')

dnl # devtools/OS/Linux has our MANROOT wrong and owner/group wrong
define(`confMANROOT', `/usr/share/man/man')
define(`confMANOWN', `root')
define(`confMANGRP', `root')
