# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTTP/PEAR-HTTP-1.4.1.ebuild,v 1.1 2009/08/26 21:03:08 beandog Exp $

inherit php-pear-r1 depend.php eutils

DESCRIPTION="Miscellaneous HTTP utilities."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

pkg_setup() {
	require_php_with_use pcre
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# fix nasty DOS linebreaks
	edos2unix HTTP.php
}
