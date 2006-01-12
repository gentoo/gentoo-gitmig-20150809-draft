# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/scilab/scilab-3.1.1-r3.ebuild,v 1.2 2006/01/12 23:21:04 compnerd Exp $

inherit eutils fortran

DESCRIPTION="Scientific software package for numerical computations (Matlab lookalike)"
LICENSE="scilab"
SRC_URI="http://scilabsoft.inria.fr/download/stable/${P}-src.tar.gz"
HOMEPAGE="http://www.scilab.org/"

SLOT="0"
IUSE="ifc ocaml tcltk gtk Xaw3d"
KEYWORDS="~x86 ~ppc"

RDEPEND="virtual/x11
	virtual/blas
	virtual/lapack
	sys-libs/ncurses
	gtk? (
		media-libs/jpeg
		media-libs/libpng
		sys-libs/zlib
		>=x11-libs/gtk+-2
		>=x11-libs/libzvt-2
		=gnome-extra/gtkhtml-2*
	)
	tcltk? ( >=dev-lang/tk-8.4
		>=dev-lang/tcl-8.4 )
	Xaw3d? ( x11-libs/Xaw3d )
	ocaml? ( dev-lang/ocaml )"

DEPEND="${RDEPEND}
	ifc? ( dev-lang/ifc )
	app-text/sablotron"

pkg_setup() {
	need_fortran g77
	if ! use gtk && ! use tcltk; then
		echo
		eerror 'scilab must be built with either USE="gtk" or USE="tcltk"'
		die
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e '/^ATLAS_LAPACKBLAS\>/s,=.*,= $(ATLASDIR)/liblapack.so $(ATLASDIR)/libblas.so $(ATLASDIR)/libcblas.so,' \
		-e 's,$(SCIDIR)/libs/lapack.a,,' \
		Makefile.OBJ.in

	# fix scilab script causing problems (#67905)
	# epatch ${FILESDIR}/${P}-initialization.patch
}

src_compile() {
	local myopts
	use tcltk || myopts="${myopts} --without-tk"
	use Xaw3d || myopts="${myopts} --without-xaw3d"
	myopts="${myopts} --with-atlas-library=/usr/lib"
	if use gtk; then
		myopts="${myopts} --with-gtk2"
	fi
	if ! use ocaml; then
		myopts="${myopts} --without-ocaml"
	fi

	econf ${myopts} || die
	env HOME="${S}" make all || die
}

src_install() {
	# These instructions come from the file ${P}/Makefile, mostly section
	# install. Make sure files have not been removed or added to these list
	# when you use this ebuild as a template for future versions.
	PVMBINDISTFILES="\
		${P}/pvm3/Readme \
		${P}/pvm3/lib/pvm \
		${P}/pvm3/lib/pvmd \
		${P}/pvm3/lib/pvmtmparch \
		${P}/pvm3/lib/pvmgetarch \
		${P}/pvm3/lib/LINUX/pvmd3 \
		${P}/pvm3/lib/LINUX/pvmgs \
		${P}/pvm3/lib/LINUX/pvm \
		${P}/pvm3/bin/LINUX/*"
	BINDISTFILES="\
		${P}/.binary \
		${P}/.pvmd.conf \
		${P}/ACKNOWLEDGEMENTS \
		${P}/CHANGES \
		${P}/Makefile \
		${P}/Makefile.OBJ \
		${P}/Makefile.incl \
		${P}/Makemex \
		${P}/Path.incl \
		${P}/README_Unix \
		${P}/Version.incl \
		${P}/configure \
		${P}/libtool \
		${P}/license.txt \
		${P}/licence.txt \
		${P}/scilab.quit \
		${P}/scilab.star \
		${P}/X11_defaults \
		${P}/bin \
		${P}/config \
		${P}/contrib \
		${P}/demos \
		${P}/examples \
		${P}/imp/NperiPos.ps \
		${P}/imp/giffonts \
		${P}/macros \
		${P}/man/eng/ \
		${P}/man/fr/ \
		${P}/man/*.dtd \
		${P}/man/*/*.xsl \
		${P}/maple \
		${P}/routines/*.h \
		${P}/routines/Make.lib \
		${P}/routines/default/FCreate \
		${P}/routines/default/Flist \
		${P}/routines/default/README \
		${P}/routines/default/fundef \
		${P}/routines/default/*.c \
		${P}/routines/default/*.f \
		${P}/routines/default/*.h \
		${P}/routines/graphics/Math.h \
		${P}/routines/graphics/Graphics.h \
		${P}/routines/graphics/Entities.h \
		${P}/routines/interf/*.h \
		${P}/routines/intersci/sparse.h \
		${P}/routines/menusX/*.h \
		${P}/routines/scicos/scicos.h \
		${P}/routines/scicos/scicos_block.h \
		${P}/routines/sun/*.h \
		${P}/routines/xsci/*.h \
		${P}/scripts \
		${P}/tcl \
		${P}/tests \
		${P}/util"

	touch .binary
	strip bin/scilex
	cd "${S}"/tests && make distclean
	cd "${S}"/examples && make distclean
	cd "${S}"/man && make man

	dodir /usr/lib
	(cd "${S}"/.. && tar cf - ${BINDISTFILES} ${PVMBINDISTFILES} | (cd "${D}"/usr/lib; tar xf -))
	rm .binary

	dodir /usr/bin
	dosym /usr/lib/${P}/bin/scilab /usr/bin/scilab
	dosym /usr/lib/${P}/bin/intersci /usr/bin/intersci
	dosym /usr/lib/${P}/bin/intersci-n /usr/bin/intersci-n

	# The compile and install process causes the work folder to be registered
	# as the runtime folder in many files. This is corrected here.
	BAD_REF="${WORKDIR}/${P}"
	FIXED_REF="/usr/lib/${P}"
	BIN_TO_FIX="Blpr BEpsf Blatexpr2 Blatexprs Blatexpr scilab"
	for i in ${BIN_TO_FIX}; do
		sed -e "s%${BAD_REF}%${FIXED_REF}%" -i "${D}"/usr/lib/${P}/bin/${i} \
			|| die
	done
	MAN_TO_FIX="eng fr"
	for i in ${MAN_TO_FIX}; do
		for j in "${D}"/usr/lib/${P}/man/${i}/*.h*; do
			sed -e "s%${BAD_REF}%${FIXED_REF}%" -i ${j} || die
		done
	done
	MISC_TO_FIX="util/Blatdoc util/Blatdocs"
	for i in ${MISC_TO_FIX}; do
		sed -e "s%${BAD_REF}%${FIXED_REF}%" -i "${D}"/usr/lib/${P}/${i} || die
	done
}

pkg_postinst() {
	einfo "To tell Scilab about your printers, set the environment"
	einfo "variable PRINTERS in the form:"
	einfo
	einfo "PRINTERS=\"firstPrinter:secondPrinter:anotherPrinter\""
}
