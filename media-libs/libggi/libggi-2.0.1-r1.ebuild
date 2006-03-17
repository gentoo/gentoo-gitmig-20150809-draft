# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libggi/libggi-2.0.1-r1.ebuild,v 1.18 2006/03/17 01:27:30 flameeyes Exp $

inherit eutils libtool

DESCRIPTION="Fast and safe graphics and drivers for about any graphics card to the Linux kernel (sometimes)"
HOMEPAGE="http://www.ggi-project.org/"
SRC_URI="http://www.ggi-project.org/ftp/ggi/v2.0/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE="X aalib svga fbcon directfb"

RDEPEND=">=media-libs/libgii-0.8.1
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
	use ppc && epatch ${FILESDIR}/libggi-${PV}-ppc.patch
}

src_compile() {
	elibtoolize

	local myconf=""

	use X \
		|| myconf="--without-x"

	use svga \
		|| myconf="${myconf} --disable-svga --disable-vgagl"

	use fbcon \
		&& myconf="${myconf} --enable-fbdev"

	use directfb \
		&& myconf="${myconf} --enable-fbdev --enable-directfb-renderer" \

	(use fbcon || use directfb) \
		|| myconf="${myconf} --disable-fbdev"

	use aalib \
		|| myconf="${myconf} --disable-aa"

	econf ${myconf} || die
	emake || die
}

src_install () {

	make \
		DESTDIR=${D} \
		install || die

	# This la file seems to bug mesa.
# Hopefully libtoolize will fix for mesa-3.5.  The *.la needed
# for mesa-5.0 in the works - <azarah@gentoo.org> (28 Dec 2002)
#	rm ${D}/usr/$(get_libdir)/*.la

	dodoc ChangeLog* FAQ NEWS README TODO
	docinto txt
	dodoc doc/*.txt
	docinto docbook
	dodoc doc/docbook/*.{dsl,sgml}
}
