# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/scilab/scilab-2.7-r3.ebuild,v 1.4 2006/04/25 13:51:34 markusle Exp $

inherit virtualx eutils

DESCRIPTION="Scientific software package for numerical computations, Matlab lookalike"
SRC_URI="ftp://ftp.inria.fr/INRIA/Projects/Meta2/Scilab/distributions/${P}.src.tar.gz
	http://www-rocq.inria.fr/scilab/bugfix/patch_browsehelp.tar.gz"
HOMEPAGE="http://www.scilab.org/"

LICENSE="scilab"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="tcltk gtk ifc"

DEPEND="x11-libs/Xaw3d
	sys-libs/ncurses
	tcltk? ( dev-lang/tk )
	x86? ( ifc? ( dev-lang/ifc ) )
	gtk? ( =x11-libs/gtk+-1.2*
			>=gnome-base/gnome-libs-1.4.2
			>=dev-libs/glib-2.2
			media-libs/jpeg
			media-libs/libpng
			sys-libs/zlib )"

pkg_setup() {
	local SCLB
	SCLB=`which scilab`
	if [ -e "${SCLB}" ]; then
		ewarn "Previous version of scilab was detected on your system"
		ewarn "Unfortunately these versions cause problems for newer ones during update"
		ewarn 'Please uninstall it with "emerge unmerge scilab" before continuig'
		die
	fi
	if ! use ifc && [ -z `which g77` ]; then
		#if ifc is defined then the dep was already checked
		eerror "No fortran compiler found on the system!"
		eerror "Please add fortran to your USE flags and reemerge gcc!"
		die
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S} && unpack ${DISTFILES}/patch_browsehelp.tar.gz
	if [ ${ARCH} = "amd64" ]; then
		epatch ${FILESDIR}/${P}-configure.patch
		cd ${S}
		autoconf
	fi
}

src_compile() {
	local myopts

	use tcltk || myopts="${myopts} --without-tk"
	use gtk && myopts="${myopts} --with-gtk" || myopts="${myopts} --without-gtk"

	econf ${myopts} || die "./configure failed"
	export HOME=${S}
	make all || die
}

src_install() {
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
		${P}/man/eng/*.htm \
		${P}/man/eng/*/*.htm \
		${P}/man/fr/*/*.htm \
		${P}/man/fr/*.htm \
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
	dodir /usr/lib
	(cd ${S}/..; tar cf - ${BINDISTFILES} ${PVMBINDISTFILES} | (cd ${D}/usr/lib; tar xf -))
	rm .binary

	dodir /usr/bin
	dosym /usr/lib/${P}/bin/scilab /usr/bin/scilab
	dosym /usr/lib/${P}/bin/intersci /usr/bin/intersci
	dosym /usr/lib/${P}/bin/intersci-n /usr/bin/intersci-n

	#now scilab wants to create some wrappers, and we will need to adjust the paths
	cd ${D}/usr/lib/${P}
	make || die "wrapper creation failed"
	cd macros && make && cd .. || die macros creation failed
	grep -rle "${D}" * | xargs sed -i -e "s:${D}:/:g"
}
