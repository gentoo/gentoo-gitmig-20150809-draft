# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/source-highlight/source-highlight-2.1.1.ebuild,v 1.1 2005/08/06 04:05:05 ka0ttic Exp $

inherit bash-completion versionator eutils

DESCRIPTION="Generate highlighted source code as an (x)html document"
HOMEPAGE="http://www.gnu.org/software/src-highlite/source-highlight.html"
SRC_URI="ftp://ftp.gnu.org/gnu/src-highlite/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~mips ~ppc ~x86"
SLOT="0"
IUSE="doc"

DEPEND="virtual/libc
	dev-libs/boost"

src_compile() {
	local myconf

	built_with_use boost threadsonly && \
		myconf="--with-boost-regex=boost_regex-gcc-mt"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	rm -fr ${D}/usr/share/doc

	dodoc AUTHORS ChangeLog COPYING CREDITS INSTALL \
		NEWS README THANKS TODO.txt || die
	dobashcompletion ${FILESDIR}/${PN}.bash-completion ${PN}

	if use doc ; then
		cd ${S}/doc
		dohtml *.html *.css *.java
	fi
}
