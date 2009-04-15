# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/allegro/allegro-4.2.2-r1.ebuild,v 1.8 2009/04/15 07:58:04 tupone Exp $

EAPI=2
inherit autotools multilib eutils

DESCRIPTION="cross-platform multimedia library"
HOMEPAGE="http://alleg.sourceforge.net/"
SRC_URI="mirror://sourceforge/alleg/${P}.tar.gz"

LICENSE="Allegro"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="X alsa arts esd fbcon jack oss svga vga"

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
	svga? ( media-libs/svgalib )
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	X? (
		x11-proto/xextproto
		x11-proto/xf86dgaproto
		x11-proto/xf86vidmodeproto
		x11-proto/xproto
	)"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-exec-stack.patch \
		"${FILESDIR}"/${P}-flags.patch \
		"${FILESDIR}"/${P}-autoconf.patch \
		"${FILESDIR}"/${P}-deplib.patch
	eautoreconf
}

src_configure() {
	LDCONFIG=/bin/true \
	econf \
		--enable-linux \
		--enable-static \
		--enable-staticprog \
		--disable-asm \
		--disable-mmx \
		--disable-sse \
		$(use_enable oss ossdigi) \
		$(use_enable oss ossmidi) \
		$(use_enable alsa alsadigi) \
		$(use_enable alsa alsamidi) \
		$(use_enable esd esddigi) \
		$(use_enable arts artsdigi) \
		$(use_with X x) \
		$(use_enable X xwin-shm) \
		$(use_enable X xwin-vidmode) \
		$(use_enable X xwin-dga2) \
		$(use_enable fbcon) \
		$(use_enable svga svgalib) \
		$(use_enable vga) \
		$(use_enable jack jackdigi)
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	dosym liballeg-${PV}.so /usr/$(get_libdir)/liballeg.so \
		|| die "dosym failed"

	if use X ; then
		newbin setup/setup ${PN}-setup || die "newbin failed"
		insinto /usr/share/${PN}
		doins {keyboard,language,setup/setup}.dat || die "doins failed"
		newicon misc/alex.png ${PN}.png
		make_desktop_entry ${PN}-setup "Allegro Setup" ${PN} "Settings"
	fi

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

pkg_postinst() {
	ewarn "Please run \"revdep-rebuild --library liballeg.so.4.2\""
	ewarn "if you are upgrading allegro from 4.2.0."
}
