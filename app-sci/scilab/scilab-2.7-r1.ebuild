# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/scilab/scilab-2.7-r1.ebuild,v 1.2 2004/04/21 18:07:11 kugelfang Exp $

DESCRIPTION="scientific software package for numerical computations"
SRC_URI="ftp://ftp.inria.fr/INRIA/Projects/Meta2/Scilab/distributions/${P}.src.tar.gz
	http://www-rocq.inria.fr/scilab/bugfix/patch_browsehelp.tar.gz"
HOMEPAGE="http://www-rocq.inria.fr/scilab/"

LICENSE="scilab"
SLOT="0"
KEYWORDS="~x86"
IUSE="tcltk Xaw3d"

DEPEND="virtual/x11
	Xaw3d? ( x11-libs/Xaw3d )
	tcltk? ( dev-lang/tk )"

src_unpack() {
	unpack ${A}
	cd ${S}
	#this "patch" is really weirdly packed, just few files that oerwrite what is already there
	unpack ${DISTFILES}/patch_browsehelp.tar.gz || die "help patch failed"
}

src_compile() {
	local myopts

	use Xaw3d || myopts="${myopts} --without-xaw3d"
	use tcltk || myopts="${myopts} --without-tk"

	econf ${myopts} || die "./configure failed"
	env HOME=${S} make all || die
}

src_install () {
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
}

# the following is needed in order to create the startup scripts with
# the right paths
pkg_postinst () {
	(cd /usr/lib/${P}; touch Path.incl; make)
}

# but of course then, unmerge won't remove everything without the following
pkg_postrm () {
	rm /usr/lib/${P}/Path.incl
	for i in Blatexpr Blatexpr2 Blatexprs Blpr BEpsf scilab ; do
		rm /usr/lib/${P}/bin/$i
	done
	rmdir /usr/lib/${P}/bin
	for i in Blatdoc Blatdocs ; do
		rm /usr/lib/${P}/util/$i
	done
	rmdir /usr/lib/${P}/util
	rmdir /usr/lib/${P}
}
