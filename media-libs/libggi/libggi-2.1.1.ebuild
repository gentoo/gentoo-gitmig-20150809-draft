# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libggi/libggi-2.1.1.ebuild,v 1.16 2006/04/15 18:36:36 vapier Exp $

inherit eutils libtool

DESCRIPTION="Fast and safe graphics and drivers for about any graphics card to the Linux kernel (sometimes)"
HOMEPAGE="http://www.ggi-project.org/"
SRC_URI="http://www.ggi-project.org/ftp/ggi/v2.1/${P}.src.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ppc ppc64 s390 sh ~sparc x86"
IUSE="X aalib svga fbcon directfb 3dfx debug mmx vis"

RDEPEND=">=media-libs/libgii-0.9.0
	X? ( || ( ( 	x11-libs/libXt
			x11-libs/libXxf86dga
			x11-libs/libXxf86vm
			x11-libs/libXt )
		virtual/x11 ) )
	svga? ( >=media-libs/svgalib-1.4.2 )
	aalib? ( >=media-libs/aalib-1.2-r1 )"

DEPEND="${RDEPEND}
	X? ( || ( (	x11-proto/xf86dgaproto
			x11-proto/xf86vidmodeproto
			x11-proto/xextproto )
		virtual/x11 ) )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-gcc4.patch"
	epatch "${FILESDIR}/${P}-glibc24.patch"
	elibtoolize
}

src_compile() {
	local myconf=""

	use svga \
		|| myconf="${myconf} --disable-svga --disable-vgagl"

	if use !fbcon && use !directfb; then
		myconf="${myconf} --disable-fbdev --disable-directfb"
	elif use directfb; then
		myconf="${myconf} --enable-fbdev --enable-directfb"
	else
		myconf="${myconf} --enable-fbdev"
	fi

	if use amd64 || use ppc64 || use ia64 ; then
		myconf="${myconf} --enable-64bitc"
	else
		myconf="${myconf} --disable-64bitc"
	fi

	econf \
		$(use_enable 3dfx glide) \
		$(use_enable aalib aa) \
		$(use_enable debug) \
		$(use_enable mmx) \
		$(use_enable vis) \
		$(use_with X x) \
		${myconf} \
		|| die "configure failed"
	emake || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"

	dodoc ChangeLog* FAQ NEWS README TODO
	docinto txt
	dodoc doc/*.txt
	docinto docbook
	dodoc doc/docbook/*.{dsl,sgml}
}
