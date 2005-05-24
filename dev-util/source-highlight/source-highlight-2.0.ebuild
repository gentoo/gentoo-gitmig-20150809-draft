# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/source-highlight/source-highlight-2.0.ebuild,v 1.1 2005/05/24 16:03:08 ka0ttic Exp $

inherit bash-completion versionator

MY_P="${PN}-$(replace_version_separator 2 -)"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Generate highlighted source code as an (x)html document"
HOMEPAGE="http://www.gnu.org/software/src-highlite/source-highlight.html"
SRC_URI="ftp://ftp.gnu.org/gnu/src-highlite/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
SLOT="0"
IUSE="doc"

DEPEND="virtual/libc
	dev-libs/boost"

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
