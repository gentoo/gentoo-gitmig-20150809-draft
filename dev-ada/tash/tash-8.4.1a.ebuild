# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/tash/tash-8.4.1a.ebuild,v 1.2 2007/02/13 14:43:58 george Exp $

inherit versionator gnat

DESCRIPTION="Tash provides tcl Ada bindings"
HOMEPAGE="http://www.tupone.it"
SRC_URI="http://dev.gentoo.org/~george/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/gnat
	=dev-lang/tcl-8.4*
	=dev-lang/tk-8.4*"

lib_compile() {
	gcc -c -O2 -o obj/tclmacro.o  src/tclmacro.c && \
	gcc -c -O2 -o obj/tkmacro.o  src/tkmacro.c && \
	gnatmake -Pbuild_stat || die "building static lib failed"

	gcc -c -O2 -fPIC -o obj_dyn/tclmacro.o  src/tclmacro.c && \
	gcc -c -O2 -fPIC -o obj_dyn/tkmacro.o  src/tkmacro.c && \
	gnatmake -Pbuild_dyn || die "building static lib failed"
}

lib_install() {
	mv ${SL}/lib/*.{ali,a,so*} ${DL}
	chmod a-w ${DL}/*.ali
}

src_install() {
	dodir "${AdalibSpecsDir}/${PN}"
	insinto "${AdalibSpecsDir}/${PN}"
	doins src/*.ad?

	#set up environment
	echo "ADA_OBJECTS_PATH=%DL%" >> ${LibEnv}
	echo "ADA_INCLUDE_PATH=${AdalibSpecsDir}/${PN}" >> ${LibEnv}

	gnat_src_install

	dohtml -r index.html web/ docs/*.htm images/
	insinto /usr/share/doc/${PF}/${DOCDESTTREE}
	doins -r apps/ demos/ tests/ docs/*.pdf
}
