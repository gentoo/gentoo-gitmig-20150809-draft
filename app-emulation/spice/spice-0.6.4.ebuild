# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spice/spice-0.6.4.ebuild,v 1.1 2011/02/17 10:28:44 dev-zero Exp $

EAPI=4

DESCRIPTION="SPICE server and client."
HOMEPAGE="http://spice-space.org/"
SRC_URI="http://spice-space.org/download/releases/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gui static-libs"

RDEPEND="~app-emulation/spice-protocol-${PV}
	>=x11-libs/pixman-0.17.7
	media-libs/alsa-lib
	media-libs/celt:0.5.1
	dev-libs/openssl
	>=x11-libs/libXrandr-1.2
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXfixes
	virtual/jpeg
	sys-libs/zlib
	gui? ( =dev-games/cegui-0.6* )"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

# maintainer notes:
# * opengl support is currently broken

src_configure() {
	local myconf=""
	use gui && myconf+="--enable-gui "
	econf ${myconf} \
		$(use_enable static-libs static)
}

src_install() {
	default
	use static-libs || rm "${D}"/usr/lib*/*.la
}
