# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/lablgl/lablgl-0.98.ebuild,v 1.5 2002/10/25 20:02:02 george Exp $

IUSE="opengl"

DESCRIPTION="Objective CAML interface for OpenGL"
HOMEPAGE="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/lablgl.html"
LICENSE="as-is"

DEPEND=">=dev-lang/ocaml-3.05
	opengl? ( virtual/opengl )"

SRC_URI="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/dist/${P}.tar.gz"
S=${WORKDIR}/lablGL-${PV}
SLOT="0"
KEYWORDS="x86"

#need to do some mangling to keep ebuild name lowercase
#(anyway package uses mixture of upper and lower case letters)
Name="LablGL"

pkg_setup() {
	#lablgl requires ocaml compiled with tk support while ocaml has it as an optional dependency
	#need to do some checks and correct situation as if necessary

	if ( ! which labltk && which ocaml ) || ! ( which labltk && which ocaml || use tcltk ); then
		einfo "#######################################################"
		einfo ""
		einfo "ebuild detected that you have ocaml compiled without tk support "
		einfo "or you do not have ocaml installed and tcltk USE flag is not defined"
		einfo ""
		einfo "lablgl requires ocaml built with tk support!!! "
		einfo ""
		einfo "Please make sure that ocaml is emerged with tk support: "
		einfo 'USE="tcltk" emerge ocaml'
		einfo "or even better add tcltk to you USE definition in make.conf"
		einfo "and [re-]build ocaml with new dependency"
		einfo ""
		einfo "#######################################################"
		
		false;
	else 
		echo "found tcltk USE flag, proceeding normally!"
	fi
}

src_unpack() {

	unpack ${A}
	
	# patch the makefile to include DESTDIR support
	cd ${S} || die
	patch -p0 < ${FILESDIR}/${Name}-${PV}-Makefile-destdir.patch || die
}

src_compile() {

	# make configuration file
	cp ${FILESDIR}/${Name}-${PV}-Makefile.config ${S}/Makefile.config || die
	
	# build
	make all opt || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc README CHANGES COPYRIGHT
}
