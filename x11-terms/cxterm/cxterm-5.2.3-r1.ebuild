# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/cxterm/cxterm-5.2.3-r1.ebuild,v 1.1 2010/09/19 02:36:37 jer Exp $

EAPI="2"

inherit autotools

SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://cxterm.sourceforge.net/"
DESCRIPTION="A Chinese/Japanese/Korean X-Terminal"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="
	sys-libs/ncurses
	x11-libs/libX11
	x11-libs/libXaw
	x11-libs/libXmu
"
DEPEND="${RDEPEND}"

src_prepare() {
	# use the canonical compiler and linker calls and...
	sed -i utils/Makefile.am \
		-e '/ -c /s|gcc|$(COMPILE)|g' \
		-e '/ -o /s|gcc|$(LINK)|g' \
		|| die "sed utils/Makefile.am"
	# ...remove these redefinitions, probably the reason why the original
	# Makefile.am above had plain `gcc' as -O[N>0] would then fail
	sed -i utils/tit2cit.c \
		-e '/extern char.*malloc.*calloc.*realloc/d' \
		|| die "sed utils/tit2cit.c"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README* INSTALL-5.2 Doc/*
	docinto tutorial-1
	dodoc Doc/tutorial-1/*
	docinto tutorial-2
	dodoc Doc/tutorial-2/*
}
