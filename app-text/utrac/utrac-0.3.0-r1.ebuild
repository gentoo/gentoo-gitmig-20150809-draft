# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/utrac/utrac-0.3.0-r1.ebuild,v 1.1 2012/03/11 14:19:53 wschlich Exp $

EAPI="4"
inherit eutils

IUSE=""
DESCRIPTION="Universal Text Recognizer and Converter"
HOMEPAGE="http://utrac.sourceforge.net/"
SRC_URI="http://utrac.sourceforge.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	epatch "${FILESDIR}"/Makefile.patch
}

src_install() {
	dobin utrac
	doman utrac.1
	dodoc README CHANGES CREDITS
	dodir ${DESTTREE}/share/utrac
	dolib.a libutrac.a
	insinto ${DESTTREE}/share/utrac
	doins charsets.dat
}
