# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript/ghostscript-7.05.5.ebuild,v 1.1 2002/09/18 18:54:25 raker Exp $

S=${WORKDIR}/espgs-${PV}

DESCRIPTION="ESP Ghostscript -- an enhanced version of GNU Ghostscript with better printer support"
SRC_URI="ftp://ftp.easysw.com/pub/ghostscript/espgs-${PV}-source.tar.bz2
ftp://ftp.easysw.com/pub/ghostscript/gnu-gs-fonts-std-6.0.tar.gz
ftp://ftp.easysw.com/pub/ghostscript/gnu-gs-fonts-other-6.0.tar.gz"
HOMEPAGE="http://www.easysw.com/"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND=">=media-libs/jpeg-6b 
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	X? ( virtual/x11 >=media-gfx/gimp-print-4.2.1 )"
RDEPEND="${DEPEND}"

src_unpack() {

	unpack espgs-${PV}-source.tar.bz2 || die
	unpack gnu-gs-fonts-std-6.0.tar.gz || die
	unpack gnu-gs-fonts-other-6.0.tar.gz || die

	# Brother HL-12XX support
	cp ${FILESDIR}/gs7.05-gdevhl12.c ${S}/src/gdevhl12.c || die
	mv ${S}/src/Makefile.in ${S}/src/Makefile.in.orig
	sed 's#^\(DEVICE_DEVS6=.*\)$#\1 $(DD)hl1240.dev $(DD)hl1250.dev#' \
	    < ${S}/src/Makefile.in.orig > ${S}/src/Makefile.in || die

}

src_compile() {

	local myconf
	myconf="--with-ijs --with-omni"

	use X && myconf="${myconf} --with-x --with-gimp-print" \
		|| myconf="${myconf} --without-x --without-gimp-print" 

	use cups && myconf="${myconf} --enable-cups" \
		|| myconf="${myconf} --disable-cups"

	econf ${myconf} || die "./configure failed"

	make || die "make failed"
}

src_install() {

	einstall install_prefix=${D} || die "make install failed"

	cd ${WORKDIR}
	cp -a fonts ${D}/usr/share/ghostscript || die
	cd ${S}

	rm -fr ${D}/usr/share/ghostscript/7.05/doc || die
	dodoc doc/README doc/COPYING doc/COPYING.LGPL
	dohtml doc/*.html doc/*.htm
	insinto /usr/share/emacs/site-lisp
	doins doc/gsdoc.el || die

}


