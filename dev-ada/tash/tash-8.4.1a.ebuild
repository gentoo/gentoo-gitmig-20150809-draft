# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/tash/tash-8.4.1a.ebuild,v 1.8 2012/05/23 08:17:28 jlec Exp $

inherit gnat toolchain-funcs

DESCRIPTION="tcl Ada bindings"
HOMEPAGE="http://tcladashell.sourceforge.net/index.htm"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/ada
	=dev-lang/tcl-8.4*
	=dev-lang/tk-8.4*"
RDEPEND=${DEPEND}

lib_compile() {
	CC=${tc-getCC}
	${CC} -c ${CFLAGS} -o obj/tclmacro.o  src/tclmacro.c && \
	${CC} -c ${CFLAGS} -o obj/tkmacro.o  src/tkmacro.c && \
	gnatmake -Pbuild_stat || die "building static lib failed"

	${CC} -c ${CFLAGS} -fPIC -o obj_dyn/tclmacro.o  src/tclmacro.c && \
	${CC} -c ${CFLAGS} -fPIC -o obj_dyn/tkmacro.o  src/tkmacro.c && \
	gnatmake -Pbuild_dyn || die "building static lib failed"
}

lib_install() {
	mv "${SL}"/lib/*.{ali,a,so*} "${DL}"
	chmod a-w "${DL}"/*.ali

	# tash build creates an absolute symlink. The easiest way to just
	# relink it here
	pushd "${DL}"
	rm libtash.so
	ln -s libtash.so.* libtash.so
	popd
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
	insinto /usr/share/doc/${PF}
	doins -r apps/ demos/ tests/ docs/*.pdf
}
