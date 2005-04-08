# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/plplot/plplot-5.5.1.ebuild,v 1.1 2005/04/08 19:27:21 cryos Exp $

inherit eutils

# Known problems with this ebuild:
# - No support for libqhull.
# - No documentation building - although prebuilt docs are in the tarball.

DESCRIPTION="A Scientific Plotting Library"
HOMEPAGE="http://plplot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc fortran gd-external gnome ifc java jpeg png python tcltk tetex truetype X itcl octave"

DEPEND="dev-util/pkgconfig
	ifc? ( dev-lang/ifc )
	virtual/libc
	sys-apps/man
	dev-lang/perl
	app-text/opensp
	python? ( dev-python/numeric )
	java? ( virtual/jre )
	tetex? ( app-text/jadetex )
	octave? ( sci-mathematics/octave )
	external-gd? ( media-libs/gd )
	truetype? ( media-libs/freetype )
	X? ( virtual/x11
		tcltk? ( dev-lang/tcl
			dev-lang/tk
			itcl? ( dev-tcltk/itcl )
		)
		gnome? ( gnome-base/gnome-libs )
	)
	doc? ( sys-apps/texinfo )"
	# Optional support for libqhull (currently doesn't work).
	# qhull? ( media-libs/qhull )

pkg_setup() {
	# If the fortran interface is wanted, the gnu f77 compiler
	# is needed unless ifc is used (which is taken care of in
	# the dependencies).
	use fortran && ! use ifc || if [ -z 'which g77' ]; then
		eerror "GNU fortran 77 compiler not found on the system."
		eerror "Please add fortran to your USE flags and reemerge gcc."
		die
	fi
}

src_unpack() {
	unpack ${A}
	# Fix compilation problems on GCC 3.4 and the octave bindings, thanks to the
	# patch from Debian's BTS bug 274359.
	epatch ${FILESDIR}/${P}-gcc-3.4-fix.patch
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
		if use tcltk; then
			EXTRA_CONF="${EXTRA_CONF} --enable-tcl"
			EXTRA_CONF="${EXTRA_CONF} $(use_enable itcl)"
		else
			EXTRA_CONF="${EXTRA_CONF} --disable-tcl"
			EXTRA_CONF="${EXTRA_CONF} --disable-tk"
			EXTRA_CONF="${EXTRA_CONF} --disable-itcl"
		fi
		EXTRA_CONF="${EXTRA_CONF} $(use_enable gnome)"
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
	if use octave; then
		# fix the path to plplot's .m files
		mv ${D}/usr/share/plplot_octave ${D}/usr/share/plplot/octave || die \
			"Error moving octave files."
		sed -i -e 's|/usr/share/plplot_octave|/usr/share/plplot/octave|' \
			${D}/usr/share/octave/site/m/PLplot/plplot_octave_path.m \
			|| die "sed replacement of octave path failed."
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
		doins plplot-5.3.1.pdf
	fi
}
