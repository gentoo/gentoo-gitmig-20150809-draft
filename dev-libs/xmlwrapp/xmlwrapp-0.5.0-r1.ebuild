# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlwrapp/xmlwrapp-0.5.0-r1.ebuild,v 1.4 2005/04/07 12:53:35 ka0ttic Exp $

inherit eutils toolchain-funcs

DESCRIPTION="modern style C++ library that provides a simple and easy interface to libxml2"
HOMEPAGE="http://pmade.org/software/xmlwrapp/"
SRC_URI="http://pmade.org/software/xmlwrapp/download/${P}.tar.gz
doc? ( http://pmade.org/software/xmlwrapp/download/documentation/${PN}-api.tar.gz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64 ~alpha"
IUSE="doc test"

RDEPEND="virtual/libc
	dev-libs/libxml2
	dev-libs/libxslt"
DEPEND="${RDEPEND}
	dev-lang/perl
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gentoo.diff
	sed -i 's/-O2//' tools/cxxflags || die "sed tools/cxxflags failed"
}

src_compile() {
	local myconf="--prefix /usr --disable-examples"
	use test && myconf="${myconf} --enable-tests"

	export CXX="$(tc-getCXX)"
	./configure.pl ${myconf} || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	sed -i "s%/usr%${D}/usr%g" Makefile || die "sed Makefile failed"
	make install || die "make install failed"

	dodoc README docs/{CREDITS,TODO,VERSION}
	if use doc ; then
		dohtml ${WORKDIR}/${PN}-api/*
		cd examples
		for ex in 0* ; do
			docinto examples/${ex}
			dodoc ${ex}/*
		done
	fi
}
