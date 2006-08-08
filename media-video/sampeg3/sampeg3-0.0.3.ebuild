# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/sampeg3/sampeg3-0.0.3.ebuild,v 1.8 2006/08/08 04:15:08 beandog Exp $

inherit eutils flag-o-matic

DESCRIPTION="MPEG video encoder targeted for optimum picture quality"
HOMEPAGE="http://rachmaninoff.informatik.uni-mannheim.de/sampeg/"
SRC_URI="http://rachmaninoff.informatik.uni-mannheim.de/sampeg/data/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="1.0"

KEYWORDS="~x86 ~ppc"

IUSE=""

RDEPEND=">=media-libs/libvideogfx-1.0
		media-libs/libpng
		media-libs/jpeg
		|| ( (
				x11-libs/libX11
				x11-libs/libXext
				x11-libs/libXv
			) virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( x11-libs/libXt virtual/x11 )"

pkg_setup() {
	append-flags -fpermissive
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-gcc4.patch"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
