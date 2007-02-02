# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/allegro/allegro-4.2.1.ebuild,v 1.3 2007/02/02 23:59:14 nyhm Exp $

inherit autotools eutils

DESCRIPTION="cross-platform multimedia library"
HOMEPAGE="http://alleg.sourceforge.net/"
SRC_URI="mirror://sourceforge/alleg/${P}.tar.gz"

LICENSE="Allegro"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 -sparc ~x86"
IUSE="X alsa arts esd fbcon mmx oss sse svga vga"

RDEPEND="alsa? ( media-libs/alsa-lib )
	esd? ( media-sound/esound )
	arts? ( kde-base/arts )
	X? (
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXpm
		x11-libs/libXt
		x11-libs/libXxf86dga
		x11-libs/libXxf86vm
	)
	svga? ( media-libs/svgalib )"
DEPEND="${RDEPEND}
	X? (
		x11-proto/xextproto
		x11-proto/xf86dgaproto
		x11-proto/xf86vidmodeproto
		x11-proto/xproto
	)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-exec-stack.patch \
		"${FILESDIR}"/${P}-flags.patch
	eautoreconf
}

src_compile() {
	econf \
		--enable-linux \
		--enable-static \
		--disable-jackdigi \
		$(use_enable mmx) \
		$(use_enable sse) \
		$(use_enable oss ossdigi) \
		$(use_enable oss ossmidi) \
		$(use_enable alsa alsadigi) \
		$(use_enable alsa alsamidi) \
		$(use_enable esd esddigi) \
		$(use_enable arts artsdigi) \
		$(use_with X x) \
		$(use_enable X xwin-shm) \
		$(use_enable X xwin-vidmode) \
		$(use_enable X xwin-dga) \
		$(use_enable X xwin-dga2) \
		$(use_enable fbcon) \
		$(use_enable svga svgalib) \
		$(use_enable vga) \
		|| die
	emake -j1 || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	# Different format versions of the Allegro documentation
	dodoc AUTHORS CHANGES THANKS readme.txt todo.txt
	doman docs/man/*.3
	doinfo docs/info/${PN}.info
	dohtml docs/html/*
	docinto txt
	dodoc docs/txt/*.txt
	docinto rtf
	dodoc docs/rtf/*.rtf
	docinto build
	dodoc docs/build/*.txt
}
