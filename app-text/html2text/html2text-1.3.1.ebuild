# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/html2text/html2text-1.3.1.ebuild,v 1.5 2004/01/20 20:15:03 avenj Exp $

DESCRIPTION="A HTML to text converter"
SRC_URI="http://userpage.fu-berlin.de/~mbayer/tools/${P}.tar.gz"
HOMEPAGE="http://userpage.fu-berlin.de/~mbayer/tools/html2text.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~amd64"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {

	unpack ${A}
	# apply a patch for g++ 3.3, provided by the html2text
	# people (see homepage) <obz@gentoo.org>
	if has_version ">=sys-devel/gcc-3.3*"; then
		epatch ${FILESDIR}/${PN}-gcc3.3.patch
	fi

}

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
