# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde/horde-2.2.1-r2.ebuild,v 1.1 2003/04/10 22:19:00 alron Exp $

DESCRIPTION="Horde Application Framework ${PV}"
HOMEPAGE="http://www.horde.org"
SRC_URI="ftp://ftp.horde.org/pub/horde/tarballs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc "
DEPEND=""
RDEPEND=">=dev-php/mod_php-4.1.0
         >=sys-devel/gettext-0.10.40
         >=dev-libs/libxml2-2.4.21
         >=net-www/horde-pear-1.0.1"
IUSE=""

# We will use these to set the permissions properly
HTTPD_USER="apache"
HTTPD_GROUP=`grep $HTTPD_USER /etc/passwd |cut -d: -f4`

# Allow users to move the default data directory by setting the
# home directory of the 'apache' user elsewhere.
HTTPD_ROOT=`grep $HTTPD_USER /etc/passwd | cut -d: -f6`/htdocs



pkg_setup() {
	if [ -z "${HTTPD_ROOT}" ]; then
		eewarn "HTTPD_ROOT is null!"
		eewarn "You probably want to check /etc/passwd"
		die "Need to have a place to put horde in"
	fi
	if [ -L ${HTTPD_ROOT}/horde ] ; then
		ewarn "You need to unmerge your old Horde version first."
		ewarn "Horde will be installed into ${HTTPD_ROOT}/horde"
		ewarn "directly instead of a version-dependant directory."
		die "need to unmerge old version first"
	fi
}


src_compile() {
	#nothing to compile
	echo "Nothing to compile"
}

src_install () {

	dodir ${HTTPD_ROOT}/horde
	cp -r . ${D}/${HTTPD_ROOT}/horde
	cp ${FILESDIR}/${PV}/vfs.sql ${D}/${HTTPD_ROOT}/horde/scripts/db
	# protecting files
	chown -R ${HTTPD_USER}.${HTTPD_GROUP} ${D}/${HTTPD_ROOT}/horde
	find ${D}/${HTTPD_ROOT}/horde/ -type f -exec chmod 0640 {} \;
	find ${D}/${HTTPD_ROOT}/horde/ -type d -exec chmod 0750 {} \;
	chmod 0000 ${D}/${HTTPD_ROOT}/horde/test.php
}

pkg_postinst() {
	einfo "Horde requires PHP to have :"
	einfo "    ==> 'short_open_tag enabled = On'"
	einfo "    ==> 'magic_quotes_runtime set = Off'"
	einfo "    ==> 'file_uploads enabled = On'"
	einfo "Please edit /etc/php4/php.ini."
	einfo ""
	einfo "Please read ${HTTPD_ROOT}/horde/docs/INSTALL !"
}


