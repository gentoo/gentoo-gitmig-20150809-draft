# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bk2site/bk2site-1.1.9.ebuild,v 1.7 2004/11/12 18:18:08 gustavoz Exp $

IUSE=""
DESCRIPTION="bk2site will transform your Netscape bookmarks file into a yahoo-like website with slashdot-like news."
SRC_URI="mirror://sourceforge/bk2site/${P}.tar.gz"
HOMEPAGE="http://bk2site.sourceforge.net/"
KEYWORDS="x86 sparc ~ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake CXXFLAGS="${CXXFLAGS}" || die
}

src_install () {
	make DESTDIR=${D} install || die
	insinto /etc/bk2site
	doins indexbase.html newbase.html otherbase.html searchbase.html
	dodoc bk2site.html *.gif
	dodoc README COPYING AUTHORS ChangeLog INSTALL TODO
	exeinto /home/httpd/cgi-bin/bk2site
	doexe *.pl
}
