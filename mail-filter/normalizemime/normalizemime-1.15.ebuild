# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/normalizemime/normalizemime-1.15.ebuild,v 1.2 2004/10/30 12:02:05 ticho Exp $

inherit toolchain-funcs

DESCRIPTION="Helper program to normalize MIME encoded messages."
HOMEPAGE="http://hyvatti.iki.fi/~jaakko/spam/"
SRC_URI="http://hyvatti.iki.fi/~jaakko/spam/${PN}.cc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/gcc
	virtual/libc"

src_unpack() {
	mkdir ${S}
	cp ${DISTDIR}/${A} ${S}
	cd ${S}
}

src_compile() {
	$(tc-getCXX) ${CXXFLAGS} -o normalizemime normalizemime.cc
}

src_install() {
	dobin normalizemime
}
