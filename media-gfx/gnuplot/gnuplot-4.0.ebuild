# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnuplot/gnuplot-4.0.ebuild,v 1.3 2004/06/07 21:55:46 agriffis Exp $

inherit eutils

MY_P="${P}.0"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Quick and useful plotting program"
HOMEPAGE="http://www.gnuplot.info/"
SRC_URI="mirror://sourceforge/gnuplot/${MY_P}.tar.gz"

LICENSE="gnuplot"
SLOT="0"
KEYWORDS="~x86"
IUSE="X svga xemacs pdflib ggi png gd readline plotutils doc"

DEPEND="
	xemacs? ( app-editors/xemacs )
	pdflib? ( media-libs/pdflib )
	ggi? ( media-libs/libggi )
	png? ( media-libs/libpng )
	gd? ( >=media-libs/libgd-2 )
	doc? ( virtual/tetex )
	X? ( virtual/x11 )
	svga? ( media-libs/svgalib )
	readline? ( >=sys-libs/readline-4.2 )
	plotutils? ( media-libs/plotutils )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/header-order.patch
}

src_compile() {
	local myconf

	myconf=""
	#myconf=" --with-lasergnu"

	use X \
		&& myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

	use svga \
		&& myconf="${myconf} --with-linux-vga" \
		|| myconf="${myconf} --without-linux-vga"

	use ggi \
		&& myconf="${myconf} --with-ggi=/usr/lib --with-xmi=/usr/lib" \
		|| myconf="${myconf} --without-ggi"

	use readline \
		&& myconf="${myconf} --with-readline=gnu --enable-history-file" \
		|| myconf="${myconf} --with-readline"

	use plotutils \
		&& myconf="${myconf} --with-plot=/usr/lib" \
		|| myconf="${myconf} --without-plot"

	use png \
		&& myconf="${myconf} --with-png=/usr/lib" \
		|| myconf="${myconf} --without-png"

	use gd \
		&& myconf="${myconf} --with-gd" \
		|| myconf="${myconf} --without-gd"

	use pdflib \
		&& myconf="${myconf} --with-pdf=/usr/lib" \
		|| myconf="${myconf} --without-pdf"

	use !xemacs && myconf="${myconf} --without-lisp-files"

	econf \
		--datadir=/usr/share/gnuplot \
		${myconf} || die

	cd ${S}
	emake || die

	if use doc ; then
		cd docs
		make pdf || die
	fi
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc BUGS ChangeLog Copyright FAQ INSTALL NEWS PATCHLEVEL PGPKEYS PORTING README* TODO VERSION
	use doc && cp docs/gnuplot.pdf ${D}/usr/share/doc/gnuplot-4.0/
	use doc && cp -a demo ${D}/usr/share/doc/gnuplot-4.0/demo
}

pkg_postinst() {
	if use svga ; then
		einfo "In order to enable ordinary users to use SVGA console graphics"
		einfo "gnuplot needs to be set up as setuid root.  Please note that"
		einfo "this is usually considered to be a security hazard."
		einfo "As root, manually chmod u+s /usr/bin/gnuplot"
	fi
}
