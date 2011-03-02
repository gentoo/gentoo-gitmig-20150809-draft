# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/sisctrl/sisctrl-0.0.20051202.ebuild,v 1.3 2011/03/02 18:02:18 signals Exp $

EAPI=2
inherit eutils

DESCRIPTION="tool that allows you to tune SiS drivers from X"
HOMEPAGE="http://www.winischhofer.net/linuxsis630.shtml"
SRC_URI="http://www.winischhofer.net/sis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	 x11-libs/gtk+:2
	 x11-libs/libXrender
	 x11-libs/libXv
	 x11-libs/libXxf86vm
	 x11-proto/xf86vidmodeproto"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-xv.patch
	sed -i 's,/X11R6,,g' configure || die
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
