# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde/horde-2.2.7.ebuild,v 1.6 2005/07/29 00:10:38 vapier Exp $

inherit horde

DESCRIPTION="Horde Application Framework"
HOMEPAGE="http://www.horde.org/"

KEYWORDS="alpha amd64 hppa ppc sparc x86"
IUSE="mysql"

DEPEND=""
RDEPEND="virtual/php
	>=sys-devel/gettext-0.10.40
	>=dev-libs/libxml2-2.4.21
	>=www-apps/horde-pear-1.3
	mysql? ( dev-php/PEAR-DB )"

pkg_setup() {
	has_version '>=virtual/php-5' \
		&& HORDE_PHP_FEATURES="nls session" \
		|| HORDE_PHP_FEATURES="nls"
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
