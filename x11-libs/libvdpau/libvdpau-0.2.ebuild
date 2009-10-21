# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libvdpau/libvdpau-0.2.ebuild,v 1.1 2009/10/21 18:40:41 cardoe Exp $

EAPI="2"

inherit autotools

DESCRIPTION="VDPAU wrapper and trace libraries"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/VDPAU"
SRC_URI="http://cgit.freedesktop.org/~aplattner/${PN}/snapshot/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

# Waiting for Aaron to provide make dist tarballs
RESTRICT="mirror"

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}
		x11-proto/xproto
		doc? ( app-doc/doxygen
			media-gfx/graphviz
			dev-tex/pdftex )"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}
