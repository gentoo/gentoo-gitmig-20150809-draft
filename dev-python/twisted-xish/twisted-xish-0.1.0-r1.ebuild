# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-xish/twisted-xish-0.1.0-r1.ebuild,v 1.7 2006/05/29 18:36:43 blubb Exp $

MY_PACKAGE=Xish

inherit twisted

DESCRIPTION="Twisted Xish is an XML library with XPath-ish and DOM-ish support."

KEYWORDS="amd64 ~ia64 ~ppc sparc x86"

DEPEND=">=dev-python/twisted-2
	<dev-python/twisted-2.4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-tests-2.1-compat.patch"
}
