# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/squirrelmail/squirrelmail-1.2.7.ebuild,v 1.3 2002/07/16 08:47:56 rphillips Exp $

S=${WORKDIR}/${P}
HTTPD_ROOT="/home/httpd/htdocs"
HTTPD_USER="apache"
HTTPD_GROUP="apache"

DESCRIPTION="Webmail for nuts!"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/squirrelmail/${P}.tar.bz2"
HOMEPAGE="http://www.squirrelmail.org"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="*"

RDEPEND="dev-php/mod_php"
DEPEND="${RDEPEND}"


pkg_setup() {
	if [ -L ${HTTPD_ROOT}/squirrelmail ] ; then
		ewarn "You need to unmerge your old SquirrelMail version first."
		ewarn "SquirrelMail will be installed into ${HTTPD_ROOT}/squirrelmail"
		ewarn "directly instead of a version-dependant directory."
		die "need to unmerge old version first"
	fi
}

src_compile() {
	#nothing to compile
	echo "Nothing to compile"
}

src_install () {
	dodir ${HTTPD_ROOT}/squirrelmail
	cp -r . ${D}/${HTTPD_ROOT}/squirrelmail
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}.${HTTPD_GROUP} squirrelmail
}

pkg_postinst() {
	einfo "Squirrelmail requires PHP to have 'register_globals = On'"
	einfo "Please edit /etc/php4/php.ini."
	einfo ""
	einfo "You will also want to move old SquirrelMail data to"
	einfo "the new location:"
	einfo ""
	einfo "\tmv ${HTTPD_ROOT}/squirrelmail-OLDVERSION/data/* \\"
	einfo "\t\t${HTTPD_ROOT}/squirrelmail/data"
	einfo "\tmv ${HTTPD_ROOT}/squirrelmail-OLDVERSION/config/config.php \\"
	einfo "\t\t${HTTPD_ROOT}/squirrelmail/config"
}
