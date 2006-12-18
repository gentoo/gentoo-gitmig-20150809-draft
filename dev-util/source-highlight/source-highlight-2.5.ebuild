# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/source-highlight/source-highlight-2.5.ebuild,v 1.1 2006/12/18 00:15:13 dev-zero Exp $

inherit autotools eutils bash-completion

DESCRIPTION="Generate highlighted source code as an (x)html document"
HOMEPAGE="http://www.gnu.org/software/src-highlite/source-highlight.html"
SRC_URI="ftp://ftp.gnu.org/gnu/src-highlite/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~mips ~ppc ~x86"
SLOT="0"
IUSE="doc"

DEPEND=">=dev-libs/boost-1.33.1-r1
	dev-util/ctags"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-exuberant-ctags.diff"
	eautoreconf
}

src_compile() {
	local myconf

	built_with_use dev-libs/boost threadsonly && \
		myconf="--with-boost-regex=boost_regex-gcc-mt"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"

	dobashcompletion "${FILESDIR}/${P}.bash-completion" ${PN}

	# That's not how we want it
	rm -fr "${D}/usr/share/doc"
	dodoc AUTHORS ChangeLog CREDITS NEWS README THANKS TODO.txt

	if use doc ; then
		cd "${S}/doc"
		dohtml *.html *.css *.java
	fi
}
