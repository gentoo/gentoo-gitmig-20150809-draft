# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Markus Krainer <markus-krainer@chello.at>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.5 2002/04/29 22:56:53 sandymac Exp

S=${WORKDIR}/${P}
DESCRIPTION="GNU Ghostscript"
SRC_URI="http://download.sourceforge.net/ghostscript/${P}.tar.bz2
	 http://download.sourceforge.net/gs-fonts/ghostscript-fonts-std-6.0.tar.gz
	 http://download.sourceforge.net/gs-fonts/gnu-gs-fonts-other-6.0.tar.gz
	 http://lxm3200.sourceforge.net/lxm3200-0.4.1-gs5.50-src.tar.gz"

DEPEND="virtual/glibc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	X? ( virtual/x11 )"
SLOT="0"

src_unpack() {

unpack ${P}.tar.bz2
unpack ghostscript-fonts-std-6.0.tar.gz
unpack gnu-gs-fonts-other-6.0.tar.gz
unpack lxm3200-0.4.1-gs5.50-src.tar.gz

cd ${WORKDIR}
patch -p0 < ${FILESDIR}/lxm3200-gentoo.diff

cp ${WORKDIR}/lxm3200-0.4.1-gs5.50-src/gdevlx32.c ${S}/src/

}


src_compile() {
	use X && myconf="--with-x"
	use X || myconf="--without-x"

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--with-gimp-print \
		${myconf} || die "./configure failed"

	make || die "make failed"
}

src_install() {

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die "make install failed"

	cd ${WORKDIR}
	cp -a fonts ${D}/usr/share/ghostscript
	cd ${S}

	rm -fr ${D}/usr/share/ghostscript/7.05/doc
	dodoc doc/README doc/COPYING doc/COPYING.LGPL
	dohtml doc/*.html doc/*.htm
	insinto /usr/share/emacs/site-lisp
	doins doc/gsdoc.el
}
