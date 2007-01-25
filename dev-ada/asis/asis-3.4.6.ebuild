# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/asis/asis-3.4.6.ebuild,v 1.3 2007/01/25 23:39:26 genone Exp $

inherit eutils flag-o-matic gnatbuild

DESCRIPTION="The Ada Semantic Interface Specification (semantic analysis and tools tied to compiler). GnuAda version"
HOMEPAGE="http://gnuada.sourceforge.net/"
LICENSE="GMGPL"

KEYWORDS="~amd64 ~x86"

Gnat_Name="gnat-gcc"
My_PV="3.4.4"
SRC_URI="http://dev.gentoo.org/~george/src/${PN}-${My_PV}.tar.bz2"

# saving slot as defined in gnatbuild.eclass
eSLOT=${SLOT}
# To avoid having two packages we combine both te name indication and the slot
# from gnatbuild.eclass in ASIS' SLOT
# eSLOT depends only on PV, so it is really static
SLOT="FSF-${eSLOT}"


IUSE="doc"
RDEPEND="=dev-lang/gnat-gcc-${PV}*"
DEPEND="${RDEPEND}
	doc? ( virtual/tetex
	app-text/texi2html )"

S="${WORKDIR}/${PN}-${My_PV}"


# it may be even better to force plain -O2 -pipe -ftracer here
replace-flags -O3 -O2


pkg_setup() {
	currGnat=$(eselect --no-color gnat show | grep "gnat-" | awk '{ print $1 }')
	if [[ "${currGnat}" != "${CTARGET}-${Gnat_Name}-${eSLOT}" ]]; then
		echo
		eerror "The active gnat profile does not correspond to the selected"
		eerror "version of asis!  Please install the appropriate gnat (if you"
		eerror "did not so yet) and run:"
		einfo  "eselect gnat set ${CTARGET}-${Gnat_Name}-${eSLOT}"
		eerror "and then emerge =dev-ada/asis-${PV} again.."
		echo
		die
	fi
}

src_unpack() {
	unpack ${A}
}


src_compile() {
	# Build the shared library first, we need -fPIC here
	gnatmake -Pasis  -cargs ${CFLAGS} || die "building libasis.a failed"
	gnatmake -Pasis_dyn -f -cargs ${CFLAGS} || die "building libasis.so failed"

	# build tools
	# we need version.o generated for all the tools
	gcc -c -o obj/version.o gnat/version.c
	for fn in asistant gnatelim gnatstub ; do
		pushd tools/${fn}
			gnatmake -o ${fn} ${fn}-driver.adb -I../../asis/ -I../../gnat/ \
				-L../../lib -cargs ${CFLAGS} -largs -lasis ../../obj/version.o \
				|| die "building ${fn} failed"
		popd
	done

	pushd tools/adabrowse
		gcc -c util-nl.c
		gnatmake -I../../asis -I../../gnat adabrowse -L../../lib -cargs	${CFLAGS} \
			-largs -lasis ../../obj/version.o || die
	popd
	pushd tools/semtools
		gnatmake -I../../asis -I../../gnat adadep -L../../lib \
			-cargs ${CFLAGS} -largs -lasis ../../obj/version.o || die
		gnatmake -I../../asis -I../../gnat adasubst -L../../lib \
			-cargs ${CFLAGS} -largs -lasis ../../obj/version.o || die
	popd

	# common stuff is just docs in this case
	if use doc; then
		pushd documentation
		make all || die "Failed while compiling documentation"
		for fn in *.ps; do ps2pdf ${fn}; done
		popd
	fi
}


src_install () {
	# we need to adjust some vars defined in gnatbuild.eclass so that they use
	# gnat-gcc instead of asis
	LIBPATH=${LIBPATH/${PN}/${Gnat_Name}}
	BINPATH=${BINPATH/${PN}/${Gnat_Name}}
	DATAPATH=${DATAPATH/${PN}/${Gnat_Name}}

	# install the lib
	dodir ${LIBPATH}/adalib
	chmod 0755 lib_dyn/libasis.so
	cp lib_dyn/libasis.so ${D}${LIBPATH}/adalib/libasis-${eSLOT}.so
	insinto ${LIBPATH}/adalib
	doins obj/*.ali
	doins lib/libasis.a
	# make appropriate symlinks
	pushd ${D}${LIBPATH}/adalib
	ln -s libasis-${eSLOT}.so libasis.so
	popd
	# sources
	insinto ${LIBPATH}/adainclude
	doins gnat/*.ad[sb]
	doins asis/*.ad[sb]

	# tools
	mkdir -p ${D}${BINPATH}
	for fn in tools/{adabrowse,asistant,gnatelim,gnatstub}; do
		cp ${fn}/${fn:6} ${D}${BINPATH}
	done
	cp tools/semtools/ada{dep,subst} ${D}${BINPATH}

	# docs and examples
	dodoc documentation/*.{txt,ps}
	dohtml documentation/*.html
	# info's should go into gnat-gpl dirs
	insinto ${DATAPATH}/info/
	doins documentation/*.info

	insinto /usr/share/doc/${PF}
	doins -r documentation/*.pdf examples/ tutorial/ templates/
}

pkg_postinst() {
	echo
	elog "The ASIS is installed for the active gnat compiler at gnat's	location."
	elog "No further configuration is necessary. Enjoy."
	echo
}
