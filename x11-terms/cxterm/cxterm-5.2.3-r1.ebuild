# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/cxterm/cxterm-5.2.3-r1.ebuild,v 1.2 2011/07/09 17:40:30 ssuominen Exp $

EAPI=4
inherit autotools

SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://cxterm.sourceforge.net/"
DESCRIPTION="A Chinese/Japanese/Korean X-Terminal"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
		|| die
	# ...remove these redefinitions, probably the reason why the original
	# Makefile.am above had plain `gcc' as -O[N>0] would then fail
	sed -i utils/tit2cit.c \
		-e '/extern char.*malloc.*calloc.*realloc/d' \
		|| die

	# Fix include guard with recent libX11 wrt #349448
	sed -i -e 's:_XLIB_H_:_X11&:' cxterm/HZtable.h || die

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc -r ChangeLog README* INSTALL-5.2 Doc/*
}
