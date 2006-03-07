# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvideogfx/libvideogfx-1.0.3.ebuild,v 1.8 2006/03/07 11:52:09 flameeyes Exp $

inherit flag-o-matic libtool

DESCRIPTION="LibVideoGfx is a C++ library for low-level video processing."
HOMEPAGE="http://rachmaninoff.informatik.uni-mannheim.de/libvideogfx/index.html"
SRC_URI="http://rachmaninoff.informatik.uni-mannheim.de/libvideogfx/data/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="1.0"

KEYWORDS="~x86 ~ppc"

IUSE=""

RDEPEND="media-libs/libpng
	media-libs/jpeg
	|| ( (
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXv
		) virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( (
			x11-libs/libXt
			x11-proto/xextproto
		) virtual/x11 )"

pkg_setup() {
	# Uses deprecated syntax, but updating it is too much effort
	append-flags -fpermissive
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-gcc4.patch"

	elibtoolize
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README TODO
}
