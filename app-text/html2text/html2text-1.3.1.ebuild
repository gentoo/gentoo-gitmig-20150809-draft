# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/html2text/html2text-1.3.1.ebuild,v 1.1 2003/09/12 08:57:19 phosphan Exp $

DESCRIPTION="A HTML to text converter"
SRC_URI="http://userpage.fu-berlin.de/~mbayer/tools/${P}.tar.gz"
HOMEPAGE="http://userpage.fu-berlin.de/~mbayer/tools/html2text.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	./configure || die
	emake || die
}

src_install() {
	dobin html2text
	doman html2text.1.gz
	doman html2textrc.5.gz
	dodoc CHANGES CREDITS INSTALL KNOWN_BUGS README TODO
}
