# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xloadimage/xloadimage-4.1.ebuild,v 1.2 2002/07/21 19:29:38 aliz Exp $

A=xloadimage.${PV}
S=${WORKDIR}/${A}
DESCRIPTION="Xloadimage is a utility which will view many different types of images under X11"
SRC_URI="ftp://ftp.x.org/R5contrib/${A}.tar.gz"
HOMEPAGE="http://gopher.std.com/homepages/jimf/xloadimage.html"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"
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

}

src_compile() {
	chmod 0755 configure
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

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
