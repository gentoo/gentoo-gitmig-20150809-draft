# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnuplot/gnuplot-3.8j.ebuild,v 1.2 2004/02/09 07:42:48 augustus Exp $

IUSE="X readline svga plotutils pdflib doc"

MY_P="${P}.0"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Quick and useful plotting program"
SRC_URI="mirror://sourceforge/gnuplot/${MY_P}.tar.gz"
HOMEPAGE="http://www.gnuplot.info"

SLOT="0"
LICENSE="gnuplot"
KEYWORDS="x86 ~ppc ~alpha ~sparc ~amd64"

# Old png driver seems to have problems; switching to gd instead
DEPEND=">=media-libs/libgd-2
	pdflib? ( media-libs/pdflib )
	doc? ( virtual/tetex )
	X? ( virtual/x11 )
	svga? ( media-libs/svgalib )
	readline? ( sys-libs/readline )
	plotutils? ( media-libs/plotutils )"

src_compile() {
	local myconf
	#--with-lasergnu flag seems to be broken and I'm too lazy to fix now
	#myconf=" --with-png --without-gd --with-lasergnu"
	myconf="  --with-gd --with-plot=/usr/lib"
	#--with-plot enables the Gnu plotutils library
	#need to specify path to differentiate from Unix plot

	use plotutils \
		&& myconf="${myconf} --with-plot=/usr/lib" \
		|| myconf="${myconf} --without-plot"

	use pdflib \
		&& myconf="${myconf} --with-pdf" \
		|| myconf="${myconf} --without-pdf"

	use X \
		&& myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

	use readline \
		&& myconf="${myconf} --with-readline=gnu" \
		|| myconf="${myconf} --with-readline"

	use svga \
		&& myconf="${myconf} --with-linux-vga" \
		|| myconf="${myconf} --without-linux-vga"

	econf \
		--datadir=/usr/share/gnuplot \
		${myconf} || die

	cd ${S}
	emake || die

	if [ -n "`use doc`" ] ; then
		cd docs
		make pdf || die
	fi
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc 0* ChangeLog CodeStyle Copyright NEWS PGPKEYS TODO
	use doc && dodoc docs/gnuplot.pdf
}

pkg_postinst() {
	if [ "`use svga`" ] ; then
		einfo "In order to enable ordinary users to use SVGA console graphics"
		einfo "gnuplot needs to be set up as setuid root.  Please note that"
		einfo "this is usually considered to be a security hazard."
		einfo "As root, manually chmod u+s /usr/bin/gnuplot"
	fi
}
