# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTTP/PEAR-HTTP-1.4.0-r1.ebuild,v 1.7 2008/03/28 23:45:10 maekke Exp $

inherit php-pear-r1 depend.php eutils

DESCRIPTION="Miscellaneous HTTP utilities."
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

pkg_setup() {
	require_php_with_use pcre
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# fix nasty DOS linebreaks and http://pear.php.net/bugs/bug.php?id=12672
	edos2unix HTTP.php
	epatch "${FILESDIR}"/${P}-trailingslash-redirect-bug12672.patch
}
