# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde/horde-3.0.ebuild,v 1.1 2004/12/24 07:19:45 vapier Exp $

inherit horde

DESCRIPTION="Horde Application Framework"
HOMEPAGE="http://www.horde.org/"

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

DEPEND=""
RDEPEND=">=dev-php/mod_php-4.1.0
	>=sys-devel/gettext-0.10.40
	>=dev-libs/libxml2-2.4.21
	>=www-apps/horde-pear-1.3"

pkg_setup() {
	has_version '>=dev-php/mod_php-5' \
		&& HORDE_PHP_FEATURES="nls session" \
		|| HORDE_PHP_FEATURES="nls"
	horde_pkg_setup
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
