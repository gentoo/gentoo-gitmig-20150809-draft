# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde/horde-3.1.2-r1.ebuild,v 1.1 2006/08/20 08:04:31 vapier Exp $

HORDE_PHP_FEATURES="session xml"

EHORDE_PATCHES="${FILESDIR}/${P}-perms.patch"

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
	dev-php/PEAR-Log
	dev-php/PEAR-Mail_Mime
	mysql? ( dev-php/PEAR-DB )"

src_unpack() {
	horde_src_unpack
	cd "${S}"
	chmod 600 scripts/sql/create.*.sql #137510
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
