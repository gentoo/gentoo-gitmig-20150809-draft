# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde/horde-2.2.5.ebuild,v 1.3 2004/03/28 17:23:50 zx Exp $

inherit horde

DESCRIPTION="Horde Application Framework"
HOMEPAGE="http://www.horde.org/"

KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa"

DEPEND=""
RDEPEND=">=dev-php/mod_php-4.1.0
	>=sys-devel/gettext-0.10.40
	>=dev-libs/libxml2-2.4.21
	>=net-www/horde-pear-1.3"

pkg_setup() {
	if [ -L ${ROOT}/${HTTPD_ROOT}/horde ] ; then
		ewarn "You need to unmerge your old Horde version first."
		ewarn "Horde will be installed into ${HTTPD_ROOT}/horde"
		ewarn "directly instead of a version-dependant directory."
		die "need to unmerge old version first"
	fi
	horde_pkg_setup
}

src_install() {
	horde_src_install
	chmod 0000 test.php
}

pkg_postinst() {
	horde_pkg_postinst
	echo
	einfo "Horde requires PHP to have:"
	einfo "    ==> 'short_open_tag enabled = On'"
	einfo "    ==> 'magic_quotes_runtime set = Off'"
	einfo "    ==> 'file_uploads enabled = On'"
	einfo "Please edit /etc/php/apache2-php4/php.ini"
}
