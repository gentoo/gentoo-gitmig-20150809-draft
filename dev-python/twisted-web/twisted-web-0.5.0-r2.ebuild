# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-web/twisted-web-0.5.0-r2.ebuild,v 1.2 2006/04/29 17:54:20 marienz Exp $

MY_PACKAGE=Web

inherit twisted eutils

DESCRIPTION="Twisted web server, programmable in Python"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sh ~sparc ~x86"

DEPEND=">=dev-python/twisted-2.2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-root-skip.patch"
	epatch "${FILESDIR}/${P}-tests-2.2-compat-14780.patch"
	epatch "${FILESDIR}/${P}-tests-2.2-compat-14782.patch"
	epatch "${FILESDIR}/${P}-tests-2.2-compat-14786.patch"
	epatch "${FILESDIR}/${P}-tests-2.2-compat.patch"
}
