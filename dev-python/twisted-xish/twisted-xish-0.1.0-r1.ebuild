# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-xish/twisted-xish-0.1.0-r1.ebuild,v 1.3 2006/04/01 19:15:39 agriffis Exp $

MY_PACKAGE=Xish

inherit twisted

DESCRIPTION="Twisted Xish is an XML library with XPath-ish and DOM-ish support."

KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"

DEPEND=">=dev-python/twisted-2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-tests-2.1-compat.patch"
}
