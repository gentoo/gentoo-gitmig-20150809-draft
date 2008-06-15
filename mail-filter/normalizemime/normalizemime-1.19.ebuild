# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/normalizemime/normalizemime-1.19.ebuild,v 1.1 2008/06/15 11:47:49 dertobi123 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Helper program to normalize MIME encoded messages"
HOMEPAGE="http://hyvatti.iki.fi/~jaakko/spam/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

src_compile() {
	$(tc-getCXX) -Wall ${CXXFLAGS} ${LDFLAGS} -o normalizemime normalizemime.cc || die
}

src_install() {
	dobin normalizemime || die
}
