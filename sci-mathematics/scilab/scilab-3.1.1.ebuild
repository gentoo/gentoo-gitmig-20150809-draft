# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/scilab/scilab-3.1.1.ebuild,v 1.4 2005/06/23 00:10:01 ribosome Exp $

inherit eutils

DESCRIPTION="Scientific software package for numerical computations (Matlab lookalike)"
SRC_URI="http://scilabsoft.inria.fr/download/stable/${P}-src.tar.gz"
HOMEPAGE="http://www.scilab.org/"

LICENSE="scilab"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="ifc ocaml tcltk atlas gtk gtk2 Xaw3d"

RDEPEND="virtual/x11
	sys-libs/ncurses
	!ppc? ( atlas? ( sci-libs/atlas ) )
	gtk? (
		media-libs/jpeg
		media-libs/libpng
		sys-libs/zlib
		gtk2? ( >=x11-libs/gtk+-2
			>=x11-libs/libzvt-2
			=gnome-extra/libgtkhtml-2*
		)
		!gtk2? ( =x11-libs/gtk+-1.2*
			>=gnome-base/gnome-libs-1.4.2 )
	)
	tcltk? ( >=dev-lang/tk-8.4
		>=dev-lang/tcl-8.4 )
	Xaw3d? ( x11-libs/Xaw3d )
	ocaml? ( dev-lang/ocaml )"

DEPEND="${RDEPEND}
	ifc? ( dev-lang/ifc )
	app-text/sablotron"

pkg_setup() {
	if ! which ${F77:-g77} &> /dev/null; then
		echo
		eerror "The Fortran compiler \"${F77:-g77}\" could not be found on your system."
		if [ -z ${F77} ] || [ ${F77} = g77 ]; then
			eerror 'Please reinstall "sys-devel/gcc" with the "fortran" "USE" flag enabled.'
		elif [ ${F77} = ifc ] && ! use ifc &> /dev/null; then
			eerror 'Please set the "ifc" "USE" flag if you want to use the Intel Fortran'
			eerror 'Compiler to build this package. This will ensure the "dev-lang/ifc"'
			eerror 'package gets installed on your system.'
		elif [ ${F77} = ifc ] && use ifc &> /dev/null; then
			eerror 'Please ensure "ifc" is in a directory referenced in "PATH".'
		else
			eerror 'Please make sure the variable ${F77} is set to the name of a valid'
			eerror 'Fortran compiler installed on your system. Make sure this executable'
			eerror 'is in a directory referenced by "PATH", and that the corresponding'
			eerror '"USE" flag is set if applicable (for example "ifc" if you use the'
			eerror 'Intel Fortran Compiler).'
		fi
		die "Fortran compiler not found."
	fi

	if ! use gtk && ! use tcltk; then
		echo
		eerror 'scilab must be built with either USE="gtk" or USE="tcltk"'
		die
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# fix scilab script causing problems (#67905)
	# epatch ${FILESDIR}/${P}-initialization.patch
}

src_compile() {
	local myopts
	use tcltk || myopts="${myopts} --without-tk"
	use Xaw3d || myopts="${myopts} --without-xaw3d"
	use atlas && myopts="${myopts} --with-atlas-library=/usr/lib"
	if use gtk; then
		use gtk2 && myopts="${myopts} --with-gtk2" || \
			myopts="${myopts} --with-gtk"
	fi
	if ! use ocaml; then
		myopts="${myopts} --without-ocaml"
	fi

	econf ${myopts} || die
	env HOME=${S} make all || die
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
	cd ${S}/tests && make distclean
	cd ${S}/examples && make distclean
	cd ${S}/man && make man

	dodir /usr/lib
	(cd ${S}/.. && tar cf - ${BINDISTFILES} ${PVMBINDISTFILES} | (cd ${D}/usr/lib; tar xf -))
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
		sed -e "s%${BAD_REF}%${FIXED_REF}%" -i ${D}/usr/lib/${P}/bin/${i} || die
	done
	MAN_TO_FIX="eng fr"
	for i in ${MAN_TO_FIX}; do
		for j in ${D}/usr/lib/${P}/man/${i}/*.h*; do
			sed -e "s%${BAD_REF}%${FIXED_REF}%" -i ${j} || die
		done
	done
	MISC_TO_FIX="util/Blatdoc util/Blatdocs"
	for i in ${MISC_TO_FIX}; do
		sed -e "s%${BAD_REF}%${FIXED_REF}%" -i ${D}/usr/lib/${P}/${i} || die
	done
}

pkg_postinst() {
	einfo "To tell Scilab about your printers, set the environment"
	einfo "variable PRINTERS in the form:"
	einfo
	einfo "PRINTERS=\"firstPrinter:secondPrinter:anotherPrinter\""
}
