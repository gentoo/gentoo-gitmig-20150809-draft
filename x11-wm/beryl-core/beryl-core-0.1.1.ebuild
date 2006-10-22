# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/beryl-core/beryl-core-0.1.1.ebuild,v 1.1 2006/10/22 22:31:31 tsunam Exp $

inherit autotools

DESCRIPTION="Beryl window manager for AiGLX and XGL"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://distfiles.xgl-coffee.org/${PN}/${P}.tar.bz2"

LICENSE="X11"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=x11-base/xorg-server-1.1.1-r1
	>=x11-libs/gtk+-2.8.0
	x11-libs/libXdamage
	x11-libs/libXrandr
	x11-libs/startup-notification"

RDEPEND="${DEPEND}
	x11-apps/xdpyinfo"

PDEPEND="x11-plugins/beryl-plugins"

S="${WORKDIR}/${PN}"
MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	eautoreconf || die "eautoreconf failed"

	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
