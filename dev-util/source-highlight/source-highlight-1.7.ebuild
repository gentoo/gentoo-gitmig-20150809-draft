# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/source-highlight/source-highlight-1.7.ebuild,v 1.6 2004/07/15 00:08:44 agriffis Exp $

IUSE=""

DESCRIPTION="Generate highlighted source code as an (x)html document"
SRC_URI="ftp://ftp.gnu.org/gnu/source-highlight/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/src-highlite/source-highlight.html"

LICENSE="GPL-2"
KEYWORDS="x86 amd64"
SLOT="0"

DEPEND="virtual/libc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	cd ${S}/src
	dobin source-highlight cpp2html java2html source-highlight-cgi
	dodir /usr/share/source-highlight
	insinto /usr/share/source-highlight
	doins tags.j2h tags2.j2h

	cd ${S}/doc
	dohtml *.html *.css *.java
	doman source-highlight.1

	dodoc AUTHORS ChangeLog COPYING CREDITS INSTALL \
		NEWS README THANKS TODO.txt
}
