# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnuplot/gnuplot-3.8j.ebuild,v 1.5 2004/04/06 17:55:06 agriffis Exp $

MY_P="${P}.0"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Quick and useful plotting program"
HOMEPAGE="http://www.gnuplot.info/"
SRC_URI="mirror://sourceforge/gnuplot/${MY_P}.tar.gz"

LICENSE="gnuplot"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~alpha amd64 ia64"
IUSE="X readline svga plotutils pdflib doc"

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

	myconf="${myconf} `use_with pdflib pdf`"
	myconf="${myconf} `use_with X x`"

	use readline \
		&& myconf="${myconf} --with-readline=gnu" \
		|| myconf="${myconf} --with-readline"

	myconf="${myconf} `use_with svga vga`"

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
