# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ivtv/xf86-video-ivtv-1.0.0.ebuild,v 1.4 2008/05/11 23:36:01 je_fro Exp $

inherit flag-o-matic x-modular
DESCRIPTION="X.Org driver for TV-out on ivtvdev cards"
HOMEPAGE="http://ivtvdriver.org/"
SRC_URI="http://dl.ivtvdriver.org/xf86-video-ivtv/${P}.tar.gz"

LICENSE="X11"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="x11-base/xorg-server
		x11-misc/imake
		media-tv/ivtv"
RDEPEND="x11-proto/xextproto
		x11-proto/videoproto
		x11-proto/xproto
		>=x11-base/xorg-server-1.1.1-r4"
XDPVER="-1"
src_compile() {

	append-flags "-I/usr/src/linux/include"
	x-modular_src_compile
}

src_install() {

	x-modular_src_install
	dodoc README || die "Failed to install doc"
}
