# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/source-highlight/source-highlight-1.11-r1.ebuild,v 1.4 2004/11/07 11:35:25 ka0ttic Exp $

inherit bash-completion

DESCRIPTION="Generate highlighted source code as an (x)html document"
HOMEPAGE="http://www.gnu.org/software/src-highlite/source-highlight.html"
SRC_URI="ftp://ftp.gnu.org/gnu/src-highlite/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc"
SLOT="0"
IUSE=""

DEPEND="virtual/libc"

src_install () {
	dodoc AUTHORS ChangeLog COPYING CREDITS INSTALL \
		NEWS README THANKS TODO.txt || die
	dobashcompletion ${FILESDIR}/${PN}.bash-completion ${PN}

	cd ${S}/src
	dobin source-highlight cpp2html java2html source-highlight-cgi \
		src-hilite-lesspipe.sh || die
	dodir /usr/share/source-highlight
	insinto /usr/share/source-highlight
	doins tags.j2h tags2.j2h || die

	cd ${S}/doc
	dohtml *.html *.css *.java || die
	doman source-highlight.1 || die
}
