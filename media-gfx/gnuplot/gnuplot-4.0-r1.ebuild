# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnuplot/gnuplot-4.0-r1.ebuild,v 1.3 2004/10/17 05:46:48 usata Exp $

inherit eutils
# inherit elisp-common

MY_P="${P}.0"

DESCRIPTION="Command-line driven interactive plotting program"
HOMEPAGE="http://www.gnuplot.info/"
SRC_URI="mirror://sourceforge/gnuplot/${MY_P}.tar.gz"
LICENSE="gnuplot"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE="doc gd ggi pdflib plotutils png readline svga X xemacs"
#IUSE="${IUSE} emacs"

DEPEND="
	xemacs? ( virtual/xemacs )
	pdflib? ( media-libs/pdflib )
	ggi? ( media-libs/libggi )
	png? ( media-libs/libpng )
	gd? ( >=media-libs/gd-2 )
	doc? ( virtual/tetex )
	X? ( virtual/x11 )
	svga? ( media-libs/svgalib )
	readline? ( >=sys-libs/readline-4.2 )
	plotutils? ( media-libs/plotutils )"
#	emacs? ( app-emacs/gnuplot-mode )

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/header-order.patch
}

src_compile() {
	local myconf="--with-gihdir=/usr/share/${PN}/gih"

	myconf="${myconf} $(use_with X x)"
	myconf="${myconf} $(use_with svga linux-vga)"
	myconf="${myconf} $(use_with gd)"
	myconf="${myconf} $(use_with plotutils plot /usr/lib)"
	myconf="${myconf} $(use_with png png /usr/lib)"
	myconf="${myconf} $(use_with pdflib pdf /usr/lib)"

	use ggi \
		&& myconf="${myconf} --with-ggi=/usr/lib --with-xmi=/usr/lib" \
		|| myconf="${myconf} --without-ggi"

	use readline \
		&& myconf="${myconf} --with-readline=gnu --enable-history-file" \
		|| myconf="${myconf} --with-readline"

	if use xemacs ; then
		export EMACS=xemacs
		myconf="${myconf} --with-lispdir=/usr/lib/xemacs/site-packages/${PN}"
	else
		export EMACS=no
		myconf="${myconf} --without-lisp-files"
	fi

	# This is a hack to avoid sandbox violations when using the Linux console.
	# Creating the DVI and PDF tutorials require /dev/svga to build the
	# example plots.
	addwrite /dev/svga

	econf ${myconf} || die
	emake || die

	if use doc ; then
		cd docs
		make pdf || die
		cd ../tutorial
		make pdf || die
	fi
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc BUGS ChangeLog FAQ NEWS PATCHLEVEL PGPKEYS PORTING README* TODO VERSION

	if use doc; then
		# Demo files
		insinto /usr/share/${PN}/demo
		doins demo/*
		# Manual
		insinto /usr/share/doc/${PF}/manual
		doins docs/gnuplot.pdf
		# Tutorial
		insinto /usr/share/doc/${PF}/tutorial
		doins tutorial/{tutorial.dvi,tutorial.pdf}
		# Documentation for making PostScript files
		insinto /usr/share/doc/${PF}/psdoc
		doins docs/psdoc/{*.doc,*.tex,*.ps,*.gpi,README}
	fi
}

pkg_postinst() {
	if use svga ; then
		einfo "In order to enable ordinary users to use SVGA console graphics"
		einfo "gnuplot needs to be set up as setuid root.  Please note that"
		einfo "this is usually considered to be a security hazard."
		einfo "As root, manually \"chmod u+s /usr/bin/gnuplot\"."
	fi
}
