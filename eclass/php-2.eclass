# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/php-2.eclass,v 1.20 2006/01/22 18:52:00 genone Exp $
# Author: Robin H. Johnson <robbat2@gentoo.org>

# This eclass is the old style of php, that was used before php-core was
# introduced.

inherit eutils flag-o-matic

EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_postinst pkg_preinst

[ -z "${MY_PN}" ] && MY_PN=php
if [ -z "${MY_PV}" ]; then
	MY_PV=${PV/_rc/RC}
	# maybe do stuff for beta/alpha/pre here too?
fi

# our major ver number
PHPMAJORVER=${MY_PV//\.*}

[ -z "${MY_P}" ] && MY_P=${MY_PN}-${MY_PV}
[ -z "${MY_PF}" ] && MY_PF=${MY_P}-${PR}
[ -z "${HOMEPAGE}" ] && HOMEPAGE="http://www.php.net/"
[ -z "${LICENSE}" ]	&& LICENSE="PHP"
[ -z "${PROVIDE}" ]	&& PROVIDE="virtual/php"
# PHP.net does automatic mirroring from this URI
[ -z "${SRC_URI_BASE}" ] && SRC_URI_BASE="http://www.php.net/distributions"
if [ -z "${SRC_URI}" ]; then
	SRC_URI="${SRC_URI_BASE}/${MY_P}.tar.bz2"
fi
# A patch for PHP for security
SRC_URI="${SRC_URI} mirror://gentoo/php-4.3.2-fopen-url-secure.patch"

# Where we work
S=${WORKDIR}/${MY_P}

IUSE="${IUSE} X crypt curl firebird flash freetds gd gd-external gdbm imap informix ipv6 java jpeg ldap mcal memlimit mysql nls oci8 odbc pam pdf png postgres qt snmp spell ssl tiff truetype xml2"

# berkdb stuff is complicated
# we need db-1.* for ndbm
# and then either of db3 or db4
IUSE="${IUSE} berkdb"
RDEPEND="${RDEPEND} berkdb? ( =sys-libs/db-1.*
							  || ( >=sys-libs/db-4.0.14-r2
								   >=sys-libs/db-3.2.9-r9
							     )
							)"

# Everything is in this list is dynamically linked agaist or needed at runtime
# in some other way
RDEPEND="
   >=sys-libs/cracklib-2.7-r7
   app-arch/bzip2
   X? ( virtual/x11 )
   crypt? ( >=dev-libs/libmcrypt-2.4 >=app-crypt/mhash-0.8 )
   curl? ( >=net-misc/curl-7.10.2 )
   x86? ( firebird? ( >=dev-db/firebird-1.0 ) )
   freetds? ( >=dev-db/freetds-0.53 )
   gd-external? ( media-libs/gd >=media-libs/jpeg-6b
                  >=media-libs/libpng-1.2.5 )
   gd? ( >=media-libs/jpeg-6b >=media-libs/libpng-1.2.5 )
   gdbm? ( >=sys-libs/gdbm-1.8.0 )
   !alpha? ( java? ( =virtual/jdk-1.4* dev-java/java-config ) )
   jpeg? ( >=media-libs/jpeg-6b )
   ldap? ( >=net-nds/openldap-1.2.11 )
   mysql? ( >=dev-db/mysql-3.23.26 )
   nls? ( sys-devel/gettext )
   odbc? ( >=dev-db/unixODBC-1.8.13 )
   pam? ( >=sys-libs/pam-0.75 )
   pdf? ( >=media-libs/pdflib-4.0.3 >=media-libs/jpeg-6b
             >=media-libs/libpng-1.2.5 >=media-libs/tiff-3.5.5 )
   png? ( >=media-libs/libpng-1.2.5 )
   postgres? ( >=dev-db/postgresql-7.1 )
   qt? ( >=x11-libs/qt-2.3.0 )
   snmp? ( net-analyzer/net-snmp )
   spell? ( app-text/aspell )
   ssl? ( >=dev-libs/openssl-0.9.5 )
   tiff? ( >=media-libs/tiff-3.5.5 )
   xml2? ( dev-libs/libxml2 >=dev-libs/libxslt-1.0.30 )
   truetype? ( =media-libs/freetype-2* =media-libs/freetype-1*
               media-libs/t1lib )
   >=net-libs/libwww-5.3.2
   >=app-text/sablotron-0.97
   dev-libs/expat
   sys-libs/zlib
   virtual/mta"

# libswf is ONLY available on x86
RDEPEND="${RDEPEND} flash? (
		x86? ( media-libs/libswf )
		>=media-libs/ming-0.2a )"

#The new XML extension in PHP5 requires libxml2-2.5.10
if [ "${PHPMAJORVER}" -ge 5 ]; then
	RDEPEND="${RDEPEND} >=dev-libs/libxml2-2.5.10"
fi

# These are extra bits we need only at compile time
DEPEND="${RDEPEND} ${DEPEND}
	imap? ( virtual/imap-c-client )
	mcal? ( dev-libs/libmcal )"
#9libs causes a configure error
DEPEND="${DEPEND} !dev-libs/9libs"
#dev-libs/libiconv causes a compile failure
DEPEND="${DEPEND} !dev-libs/libiconv"

#Waiting for somebody to want this:
#cyrus? ( net-mail/cyrus-imapd net-mail/cyrus-imap-admin dev-libs/cyrus-imap-dev )

#export this here so we can use it
myconf="${myconf}"

PHP_INSTALLTARGETS="${PHP_INSTALLTARGETS} install-modules install-programs"

# These are quick fixups for older ebuilds that didn't have PHPSAPI defined.
[ -z "${PHPSAPI}" ] && [ "${PN}" = "php" ] && PHPSAPI="cli"
if [ -z "${PHPSAPI}" ] && [ "${PN}" = "mod_php" ]; then
	use apache2 && PHPSAPI="apache2" || PHPSAPI="apache1"
fi

# Now enforce existance of PHPSAPI
if [ -z "${PHPSAPI}" ]; then
	msg="The PHP eclass needs a PHPSAPI setting!"
	eerror "${msg}"
	die "${msg}"
fi
# build the destination and php.ini details
PHPINIDIRECTORY="/etc/php/${PHPSAPI}-php${PHPMAJORVER}"
PHPINIFILENAME="php.ini"

php_src_unpack() {
	die "This eclass must NOT be used."
}
php_src_compile() {
	die "This eclass must NOT be used."
}
php_src_install() {
	die "This eclass must NOT be used."
}
php_pkg_preinst() {
	eerror "Warning it is NOT safe to use this version of PHP anymore"
	eerror "You MUST upgrade to a newer version of PHP."
}

php_pkg_postinst() {
	eerror "Warning it is NOT safe to use this version of PHP anymore"
	eerror "You MUST upgrade to a newer version of PHP."
}
