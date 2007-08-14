# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/plplot/plplot-5.5.2.ebuild,v 1.11 2007/08/14 21:44:33 mr_bones_ Exp $

inherit eutils

# Known problems with this ebuild:
# - No support for libqhull.
# - No documentation building - although prebuilt docs are in the tarball.

DESCRIPTION="A Scientific Plotting Library"
HOMEPAGE="http://plplot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="X debug doc fortran ifc itcl java jpeg octave png python tk tetex truetype"

RDEPEND="virtual/libc
		 dev-lang/perl
	  	 python? ( dev-python/numeric )
	  	 java? ( virtual/jre )
	  	 tetex? ( app-text/jadetex )
	  	 octave? ( sci-mathematics/octave )
	  	 jpeg? ( media-libs/gd )
	  	 png? ( media-libs/gd )
	  	 truetype? ( media-libs/freetype )
		 X? ( x11-libs/libX11
				x11-libs/libXau
				x11-libs/libXdmcp
				tk? ( dev-lang/tk
						itcl? ( dev-tcltk/itcl )
						)
			   )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	ifc? ( dev-lang/ifc )
	virtual/man
	app-text/opensp
	java? ( virtual/jdk )
	X? ( x11-proto/xproto )
	doc? ( sys-apps/texinfo )"
	# Optional support for libqhull (currently doesn't work).
	# qhull? ( media-libs/qhull )

pkg_setup() {
	# If the fortran interface is wanted, the gnu f77 compiler
	# is needed unless ifc is used (which is taken care of in
	# the dependencies).
	use fortran && ! use ifc || if [[ -z $(type -P g77) ]]; then
		eerror "GNU fortran 77 compiler not found on the system."
		eerror "Please add fortran to your USE flags and reemerge gcc."
		die
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	# Fix compilation problems on GCC 3.4 and the octave
	# bindings, thanks to the patch from Debian's BTS bug 274359.
	epatch ${FILESDIR}/${PN}-5.5.1-gcc-3.4-fix.patch
	epatch ${FILESDIR}/${P}-macro-fix.patch

	# properly detect octave 2.9.x
	sed -e "s:filepath:filedir:" \
		-e "s:plplot_octave$:plplot/octave:" \
		-i configure \
		|| die "Failed to make configure octave 2.9.x aware"
}

src_compile() {
	# Doesn't compile with j > 1.
	MAKEOPTS="${MAKEOPTS} -e -j1"

	local EXTRA_CONF

	# Export DATA_DIR and DOC_DIR so that configure uses correct install path
	EXTRA_CONF="${EXTRA_CONF} DATA_DIR=\"/usr/share/${PN}\""
	EXTRA_CONF="${EXTRA_CONF} DOC_DIR=\"/usr/share/doc/${PF}\""

	# Use pkg-config
	EXTRA_CONF="${EXTRA_CONF} --with-pkg-config"

	# Compilation options (debug, documentation).
	EXTRA_CONF="${EXTRA_CONF} $(use_with debug)"
	# Documentation building doesn't work.
	# The xml catalogs are not found.
#	 if use doc; then
#	 	EXTRA_CONF="${EXTRA_CONF} --enable-builddoc \
#	 	--with-xml-declaration=/usr/share/sgml/xml.dcl \
#		--with-sgml-catalogs=/etc/sgml/catalog:/usr/share/sgml/docbook/sgml-dtd-4.2/catalog:/usr/share/sgml/docbook/sgml-dtd-4.2/docbook.dtd:/usr/share/sgml/docbook/sgml-dtd-4.2/docbookx.dtd"
#		EXTRA_CONF="${EXTRA_CONF} --with-db2x_texixml=/usr/bin/db2x_texixml.pl --with-db2x_xsltproc=/usr/bin/db2x_xsltproc.pl"
#	 else
#	 	EXTRA_CONF="${EXTRA_CONF} --disable-builddoc"
#	 fi
	EXTRA_CONF="${EXTRA_CONF} --disable-builddoc"

	# Language bindings.
	EXTRA_CONF="${EXTRA_CONF} $(use_enable python)"
	EXTRA_CONF="${EXTRA_CONF} $(use_enable java)"
	EXTRA_CONF="${EXTRA_CONF} $(use_enable octave)"
	if use ifc; then
		EXTRA_CONF="${EXTRA_CONF} --enable-f77 F77=/opt/intel/compiler70/ia32/bin/ifc"
	elif use fortran; then
		EXTRA_CONF="${EXTRA_CONF} --enable-f77"
	else
		EXTRA_CONF="${EXTRA_CONF} --disable-f77"
	fi

	# Device drivers.
	EXTRA_CONF="${EXTRA_CONF} $(use_enable jpeg)"
	EXTRA_CONF="${EXTRA_CONF} $(use_enable png)"
	EXTRA_CONF="${EXTRA_CONF} $(use_enable tetex pstex)"
	# Dynamic driver loading causes segfaults.
	EXTRA_CONF="${EXTRA_CONF} --disable-dyndrivers"
	# The linuxvga driver doesn't compile.
	EXTRA_CONF="${EXTRA_CONF} --disable-linuxvga"

	# Support for optional libraries.
	EXTRA_CONF="${EXTRA_CONF} $(use_with truetype freetype)"
	# Support for libqhull doesn't work. The configure script
	# doesn't find the lib.
	# EXTRA_CONF="${EXTRA_CONF} $(use_with qhull)"
	EXTRA_CONF="${EXTRA_CONF} --without-qhull"

	# Additional X-dependent language bindings and device drivers.
	if use X; then
		EXTRA_CONF="${EXTRA_CONF} --with-x"
		if use tk; then
			EXTRA_CONF="${EXTRA_CONF} --enable-tcl"
			EXTRA_CONF="${EXTRA_CONF} $(use_enable itcl)"
		else
			EXTRA_CONF="${EXTRA_CONF} --disable-tcl"
			EXTRA_CONF="${EXTRA_CONF} --disable-tk"
			EXTRA_CONF="${EXTRA_CONF} --disable-itcl"
		fi
		EXTRA_CONF="${EXTRA_CONF} --disable-gnome"
	else
		EXTRA_CONF="${EXTRA_CONF} --without-x"
		EXTRA_CONF="${EXTRA_CONF} --disable-tcl"
		EXTRA_CONF="${EXTRA_CONF} --disable-itcl"
		EXTRA_CONF="${EXTRA_CONF} --disable-gnome"
	fi

	econf ${EXTRA_CONF} || die
	emake || die "make step failed."
}

src_install() {

	# A little sed magic to make some of the docs install to the right place
	sed -i -e "s|\$(datadir)/doc/plplot|/usr/share/doc/${PF}|" Makefile || \
		die "sed replacement of docs dir failed."

	make install DESTDIR=${D} || die "make install step failed."

	# To match the Gentoo FSH.
	if use java; then
		mv ${D}/usr/lib/java/plplot ${D}/usr/share/${PN}/lib
		rm -r ${D}/usr/lib/java
	fi

	# Fix permissions and gzip the basic documentation.
	chmod 644 ${D}/usr/share/doc/${PF}/*
	gzip ${D}/usr/share/doc/${PF}/*
	# Install prebuilt documentation.
	if use doc; then
		cd doc/docbook/src/
		dohtml *.html
		doinfo plplotdoc.info
		insinto /usr/share/doc/${PF}
		doins ${P}.pdf
	fi
}
