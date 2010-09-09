# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmxkb/wmxkb-1.2.2.ebuild,v 1.9 2010/09/09 10:33:35 s4t4n Exp $

EAPI=2
IUSE=""

DESCRIPTION="Dockable keyboard layout switcher for Window Maker"
HOMEPAGE="http://wmalms.tripod.com/#WMXKB"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc x86"

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto
	x11-proto/inputproto"

src_prepare() {
	#Honour Gentoo LDFLAGS, see bug #336528.
	sed -ie "s/\$(LD) -o/\$(LD) \$(LDFLAGS) -o/" Makefile.in
}

src_install () {
	make DESTDIR="${D}" BINDIR="${D}/usr/bin" DOCDIR="${D}/usr/share/doc" DATADIR="${D}/usr/share" install

	#install binary by hand per bug #242188
	dobin wmxkb

	dodoc README
	cd "${WORKDIR}/${P}/doc"
	dodoc manual_body.html manual_title.html manual.book
}
