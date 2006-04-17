# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdv/libdv-0.104-r1.ebuild,v 1.9 2006/04/17 14:59:09 flameeyes Exp $

inherit eutils flag-o-matic libtool

DESCRIPTION="Software codec for dv-format video (camcorders etc)"
HOMEPAGE="http://libdv.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz mirror://gentoo/libdv-0.104-pic-fix.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE="debug gtk sdl xv"

RDEPEND="dev-libs/popt
	gtk? ( =x11-libs/gtk+-1.2* )
	sdl? ( >=media-libs/libsdl-1.2.5 )
	xv? ( || ( x11-libs/libXv virtual/x11 ) )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	gtk? ( || ( ( x11-proto/xextproto x11-libs/libXt ) virtual/x11 ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.99-2.6.patch
	epatch "${FILESDIR}"/${PN}-0.104-amd64reloc.patch
	epatch "${FILESDIR}"/${PN}-0.104-no-exec-stack.patch
	# big patch.. test here hard and fast then push upstream
	epatch "${WORKDIR}"/libdv-0.104-pic-fix.patch

	# tiny gcc4 fixes
	epatch "${FILESDIR}"/${PN}-0.104-gcc4.patch
	# fix from fedora
	epatch "${FILESDIR}"/${PN}-0.103-mmx.patch

	epatch "${FILESDIR}/${P}-inline.patch"

	elibtoolize
	epunt_cxx #74497
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
