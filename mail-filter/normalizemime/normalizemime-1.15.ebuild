# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/normalizemime/normalizemime-1.15.ebuild,v 1.8 2007/04/07 10:55:20 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="Helper program to normalize MIME encoded messages"
HOMEPAGE="http://hyvatti.iki.fi/~jaakko/spam/"
SRC_URI="http://hyvatti.iki.fi/~jaakko/spam/${PN}.cc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}"/${A} "${S}" || die
}

src_compile() {
	$(tc-getCXX) -Wall ${CXXFLAGS} ${LDFLAGS} -o normalizemime normalizemime.cc || die
}

src_install() {
	dobin normalizemime || die
}
