# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

A=xloadimage.${PV}
S=${WORKDIR}/${A}
DESCRIPTION="Xloadimage is a utility which will view many different types of images under X11"
SRC_URI="ftp://ftp.x.org/R5contrib/${A}.tar.gz"
HOMEPAGE="http://gopher.std.com/homepages/jimf/xloadimage.html"
LICENSE=""
DEPEND="x11-base/xfree
	tiff? ( media-libs/tiff )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )"
#RDEPEND=""

src_unpack() {
	unpack ${A}.tar.gz
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff
	
	cp Make.conf Make.conf.orig
	sed -e "s:OPT_FLAGS=:OPT_FLAGS=$CFLAGS:" Make.conf.orig >Make.conf

#	use jpeg && \
#		cp Make.conf Make.conf.orig
#		sed -e "s:OPTIONAL_SRCS=:OPTIONAL_SRCS=jpeg.c :" \
#		    -e "s:OPTIONAL_LIBS=:OPTIONAL_LIBS=jpeg/libjpeg.a :" \
#		    -e "s:CC_FLAGS=:CC_FLAGS=-DHAS_JPEG :" Make.conf.orig >Make.conf
#
#	use tiff && \
#		cp Make.conf Make.conf.orig
#		sed -e "s:OPTIONAL_SRCS=:OPTIONAL_SRCS=tiff.c :" \
#		    -e "s:OPTIONAL_LIBS=:OPTIONAL_LIBS=tiff/libtiff.a :" \
#		    -e "s:CC_FLAGS=:CC_FLAGS=-DHAS_TIFF :" Make.conf.orig >Make.conf

}

src_compile() {

	chmod 0755 configure
	./configure \
                --host=${CHOST} \
                --prefix=/usr \
                --infodir=/usr/share/info \
                --mandir=/usr/share/man || die "./configure failed"



	#emake || die
	make || die
}

src_install () {
	dobin xloadimage
	dosym /usr/bin/xloadimage /usr/bin/xsetbg
	dosym /usr/bin/xloadimage /usr/bin/xview
	dobin uufilter

	insinto /etc/X11
        doins xloadimagerc

	mv xloadimage.man xloadimage.1
	mv uufilter.man uufilter.1

	doman xloadimage.1
	doman uufilter.1

	dosym /usr/share/man/man1/xloadimage.1.gz /usr/share/man/man1/xsetbg.1.gz
	dosym /usr/share/man/man1/xloadimage.1.gz /usr/share/man/man1/xview.1.gz

	dodoc README

}
