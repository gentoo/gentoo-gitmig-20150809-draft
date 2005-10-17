# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/source-highlight/source-highlight-2.2.ebuild,v 1.1 2005/10/17 14:22:39 ka0ttic Exp $

inherit eutils bash-completion

DESCRIPTION="Generate highlighted source code as an (x)html document"
HOMEPAGE="http://www.gnu.org/software/src-highlite/source-highlight.html"
SRC_URI="ftp://ftp.gnu.org/gnu/src-highlite/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~mips ~ppc ~x86"
SLOT="0"
IUSE="doc"

DEPEND="dev-libs/boost
	dev-util/ctags"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-exuberant-ctags.diff
}

src_compile() {
	local myconf

	einfo "Regenerating autoconf/automake files"
	libtoolize --copy --force || die "libtoolize failed"
	aclocal || die "aclocal failed"
	autoheader || die "autoheader failed"
	automake --add-missing --copy || die "automake failed"
	autoconf || die "autoconf failed"

	built_with_use dev-libs/boost threadsonly && \
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
