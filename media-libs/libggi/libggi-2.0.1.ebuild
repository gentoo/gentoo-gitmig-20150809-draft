# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libggi/libggi-2.0.1.ebuild,v 1.17 2005/03/28 04:58:21 chriswhite Exp $

inherit eutils

IUSE="X aalib svga directfb"

DESCRIPTION="Fast and safe graphics and drivers for about any graphics card to the Linux kernel (sometimes)"
SRC_URI="http://www.ggi-project.org/ftp/ggi/v2.0/${P}.tar.bz2"
HOMEPAGE="http://www.ggi-project.org/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=">=media-libs/libgii-0.8.1
	X? ( virtual/x11 )
	svga? ( >=media-libs/svgalib-1.4.2 )
	aalib? ( >=media-libs/aalib-1.2-r1 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	if [ ${ARCH} = "ppc" ]
	then
		epatch ${FILESDIR}/libggi-${PV}-ppc.patch || die "epatch failed"
	fi
}

src_compile() {

	local myconf

	use X \
		|| myconf="--without-x"

	use svga \
		|| myconf="${myconf} --disable-svga --disable-vgagl"

	use directfb \
		&& myconf="${myconf} --enable-fbdev --enable-directfb-renderer" \
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

	#This la file seems to bug mesa
	rm ${D}/usr/lib/*.la

	dodoc ChangeLog* FAQ NEWS README TODO
	docinto txt
	dodoc doc/*.txt
	docinto docbook
	dodoc doc/docbook/*.{dsl,sgml}

}
