# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/lablgl/lablgl-0.99-r1.ebuild,v 1.2 2004/03/22 22:54:49 mattam Exp $

IUSE="tcltk"

DESCRIPTION="Objective CAML interface for OpenGL"
HOMEPAGE="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/lablgl.html"
LICENSE="as-is"

DEPEND=">=dev-lang/ocaml-3.05
	virtual/opengl
	tcltk? ( >=dev-lang/tcl-8.3*
			 >=dev-lang/tk-8.3* )"

SRC_URI="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/dist/${P}.tar.gz
	mirror://gentoo/LablGL-0.99-Makefile-destdir.patch
	mirror://gentoo/LablGL-0.99-Makefile.config"
S=${WORKDIR}/lablGL-${PV}
SLOT="0"
KEYWORDS="x86 ppc ~sparc"

#need to do some mangling to keep ebuild name lowercase
#(anyway package uses mixture of upper and lower case letters)
Name="LablGL"

pkg_setup()
{
	if ( use tcltk )
	then
		#lablgl requires ocaml compiled with tk support while ocaml has it as an optional dependency
		if ( ! which labltk )
		then
			eerror "It seems you don't have ocaml compiled with tk support"
			eerror ""
			eerror "lablgl requires ocaml be built with tk support."
			eerror ""
			eerror "Please make sure that ocaml is installed with tk support."
			false;
		fi
	fi
}

src_unpack() {
	unpack ${A}

	# patch the makefile to include DESTDIR support
	cd ${S} || die
	patch -p0 < ${DISTDIR}/${Name}-${PV}-Makefile-destdir.patch || die
}

src_compile() {
	# make configuration file
	cp ${DISTDIR}/${Name}-${PV}-Makefile.config ${S}/Makefile.config || die

	if ( use tcltk )
	then
		make || die
		make opt || die
	else
		make lib || die
		make libopt || die
	fi
}

src_install () {
	# Makefile do not use mkdir so the library is not installed 
	# but copied as a 'stublibs' file.
	dodir /usr/lib/ocaml/stublibs

	if ( use tcltk )
	then
		make DESTDIR=${D} install || die
	else
		make DESTDIR=${D} libinstall || die
	fi

	dodoc README CHANGES COPYRIGHT
}
