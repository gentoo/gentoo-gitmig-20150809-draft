# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/html2text/html2text-1.3.2.ebuild,v 1.2 2004/06/08 12:33:28 dholm Exp $

inherit eutils gcc

DESCRIPTION="A HTML to text converter"
HOMEPAGE="http://userpage.fu-berlin.de/~mbayer/tools/html2text.html"
SRC_URI="http://userpage.fu-berlin.de/~mbayer/tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	if [ `gcc-major-version` -ge 3 -a `gcc-minor-version` -ge 3 ]
	then
		epatch 1.3.2_to_1.3.2a.diff
	fi
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dobin html2text
	doman html2text.1.gz
	doman html2textrc.5.gz
	dodoc CHANGES CREDITS INSTALL KNOWN_BUGS README TODO
}
