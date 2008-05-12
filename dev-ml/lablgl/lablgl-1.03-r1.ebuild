# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/lablgl/lablgl-1.03-r1.ebuild,v 1.7 2008/05/12 16:12:01 maekke Exp $

inherit multilib eutils toolchain-funcs

EAPI="1"

IUSE="doc glut +ocamlopt tk"

DESCRIPTION="Objective CAML interface for OpenGL"
HOMEPAGE="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/lablgl.html"
LICENSE="BSD"

DEPEND=">=dev-lang/ocaml-3.05
	virtual/opengl
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libX11
	glut? ( virtual/glut )
	tk? ( >=dev-lang/tcl-8.3
	>=dev-lang/tk-8.3 )"

SRC_URI="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/dist/${P}.tar.gz"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86 ~x86-fbsd"

pkg_setup() {
	if use tk && ! built_with_use dev-lang/ocaml tk ; then
		eerror "You don't have ocaml compiled with tk support"
		eerror ""
		eerror "lablgl requires ocaml be built with tk support."
		eerror ""
		eerror "Please recompile ocaml with tk useflag enabled."
		die "Ocaml is missing tk support"
	fi

	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-tk8.5.patch"
}

src_compile() {
	# make configuration file
	echo "BINDIR=/usr/bin" > Makefile.config
	echo "GLLIBS = -lGL -lGLU" >> Makefile.config
	if use glut; then
		echo "GLUTLIBS = -lglut" >> Makefile.config
	else
		echo "GLUTLIBS = " >> Makefile.config
	fi
	echo "XLIBS = -lXext -lXmu -lX11" >> Makefile.config
	echo "RANLIB = $(tc-getRANLIB)" >> Makefile.config
	echo 'COPTS = -c -O $(CFLAGS)' >> Makefile.config
	echo 'INCLUDES = $(TKINCLUDES) $(GLINCLUDES) $(XINCLUDES)' >> Makefile.config

	if use tk; then
		emake -j1 togl || die "failed to build togl"
		if use ocamlopt; then
			emake -j1 toglopt || die "failed to build native code togl"
		fi
	fi

	emake -j1 lib || die "failed to build the library"
	if use ocamlopt; then
		emake -j1 libopt || die "failed to build native code library"
	fi

	if use glut; then
		emake -j1 glut || die "failed to build glut"
		if use ocamlopt; then
			emake -j1 glutopt || die "failed to build native code glutopt"
		fi
	fi
}

src_install () {
	# Makefile do not use mkdir so the library is not installed
	# but copied as a 'stublibs' file.
	dodir /usr/$(get_libdir)/ocaml/stublibs

	# Same for lablglut's toplevel
	dodir /usr/bin

	BINDIR=${D}/usr/bin
	BASE=${D}/usr/$(get_libdir)/ocaml
	emake BINDIR="${BINDIR}" INSTALLDIR="${BASE}/lablGL" DLLDIR="${BASE}/stublibs" install || die "make install failed"

	dodoc README CHANGES

	if use doc ; then
		insinto /usr/share/doc/${PF}
		mv Togl/examples{,.togl}
		doins -r Togl/examples.togl

		mv LablGlut/examples{,.glut}
		doins -r LablGlut/examples.glut
	fi
}
