# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdv/libdv-0.104.ebuild,v 1.2 2005/01/12 04:06:39 vapier Exp $

inherit eutils libtool

DESCRIPTION="Software codec for dv-format video (camcorders etc)"
HOMEPAGE="http://libdv.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ia64 ~x86"
IUSE="debug gtk sdl xv"

RDEPEND="dev-libs/popt
	gtk? ( =x11-libs/gtk+-1.2* )
	sdl? ( >=media-libs/libsdl-1.2.4.20020601 )
	xv? ( virtual/x11 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.99-2.6.patch
	epatch "${FILESDIR}"/${PN}-0.104-amd64reloc.patch
	epunt_cxx #74497
	uclibctoolize #74497
}

src_compile() {
	econf \
		$(use_with debug) \
		$(use_enable gtk) $(use_enable gtk gtktest) \
		$(use_enable sdl) \
		$(use_enable xv) \
		|| die "econf failed"
	make || die "compile problem"
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README* TODO
}
