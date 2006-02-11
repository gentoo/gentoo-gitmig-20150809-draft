# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/clanlib/clanlib-0.6.5-r3.ebuild,v 1.6 2006/02/11 16:57:21 joshuabaergen Exp $

inherit eutils flag-o-matic

DESCRIPTION="multi-platform game development library"
HOMEPAGE="http://www.clanlib.org/"
SRC_URI="http://www.clanlib.org/download/legacy/ClanLib-${PV}-1.tar.gz"

LICENSE="LGPL-2"
SLOT="0.6"
KEYWORDS="amd64 x86" #not big endian safe #82779
IUSE="arts oss esd alsa png opengl truetype X vorbis mikmod jpeg directfb joystick"

DEPEND=">=media-libs/hermes-1.3.2
	X? (
		|| (
			( media-libs/mesa
			x11-libs/libXt
			x11-proto/inputproto
			x11-proto/xf86vidmodeproto )
			virtual/x11
		)
	)
	png? ( media-libs/libpng )
	jpeg? ( >=media-libs/jpeg-6b )
	mikmod? ( >=media-libs/libmikmod-3.1.9 )
	truetype? ( >=media-libs/freetype-2.0 )
	directfb? ( dev-libs/DirectFB )
	vorbis? ( media-libs/libvorbis )"
RDEPEND="${DEPEND}
	|| (
		( media-libs/mesa
		x11-libs/libXmu
		x11-libs/libXxf86vm )
		virtual/x11
	)"

S=${WORKDIR}/ClanLib-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc3.patch
	epatch "${FILESDIR}"/${P}-DirectFB-update.patch
	epatch "${FILESDIR}"/${P}-freetype.patch
	epatch "${FILESDIR}"/${P}-gcc41.patch
	sed -i 's:@comp_mode@::' Setup/Unix/clanlib-config.in
}

src_compile() {
	local myconf=""

	replace-flags -O? -O2

	use jpeg || myconf="${myconf} --enable-smalljpeg"
	use alsa || use oss || use esd || use arts \
		&& myconf="${myconf} --enable-clansound" \
		|| myconf="${myconf} --disable-clansound"

	econf \
		--libdir=/usr/$(get_libdir)/${P} \
		--includedir=/usr/include/${P} \
		--enable-network \
		$(use_enable x86 asm386) \
		--enable-dyn \
		$(use_enable X x11) \
		$(use_enable directfb) \
		$(use_enable opengl) \
		$(use_enable vorbis) \
		$(use_enable png) \
		$(use_enable truetype ttf) \
		$(use_enable mikmod) \
		$(use_enable joystick) \
		--enable-vidmode \
		${myconf} || die

	emake || die "emake failed"
}

src_install() {
	make install \
		prefix="${D}"/usr \
		LIB_PREFIX="${D}"/usr/$(get_libdir)/${P} \
		INC_PREFIX="${D}"/usr/include/${P} \
		|| die "make install failed"
	mv "${D}"/usr/bin/clanlib{,0.6}-config
	dodoc BUGS CODING_STYLE HARDWARE NEWS PATCHES PORTING README* ROADMAP INSTALL.linux

	# setup links for runtime
	cd "${D}"/usr/$(get_libdir)
	local l
	for l in ${P}/*.2 ; do
		ln -s ${l}
	done
}
