# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libggi/libggi-2.0.1.ebuild,v 1.3 2002/07/11 06:30:39 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Fast and safe graphics and drivers for about any graphics card to the Linux kernel (sometimes)"
SRC_URI="http://www.ggi-project.org/ftp/ggi/v2.0/${P}.tar.bz2"
HOMEPAGE="http://www.ggi-project.org/"

DEPEND=">=media-libs/libgii-0.8.1
		X? ( virtual/x11 )
		svga? ( >=media-libs/svgalib-1.4.2 )
		aalib? ( >=media-libs/aalib-1.2-r1 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	if [ ${ARCH} = "ppc" ]
	then patch -p1 < ${FILESDIR}/libggi-${PV}-ppc.patch || die
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

	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		${myconf} || die

	emake || die

}

src_install () {

	make \
		DESTDIR=${D} \
		install || die

	#This la file seems to bug mesa
	rm ${D}/usr/lib/*.la

	dodoc ChangeLog* FAQ NEWS README
	docinto txt
	dodoc doc/*.txt
	docinto docbook
	dodoc doc/docbook/*.{dsl,sgml}

}
