# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mercury-extras/mercury-extras-10.04.2.ebuild,v 1.1 2010/10/10 05:32:54 keri Exp $

inherit eutils

DESCRIPTION="Additional libraries and tools that are not part of the Mercury standard library"
HOMEPAGE="http://www.cs.mu.oz.au/research/mercury/index.html"
SRC_URI="http://www.mercury.cs.mu.oz.au/download/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE="X examples glut iodbc ncurses odbc opengl tcl tk xml"

DEPEND="~dev-lang/mercury-${PV}
	glut? ( media-libs/freeglut )
	odbc? ( dev-db/unixODBC )
	iodbc? ( !odbc? ( dev-db/libiodbc ) )
	ncurses? ( sys-libs/ncurses )
	opengl? ( virtual/opengl )
	tcl? ( tk? (
			dev-lang/tcl
			dev-lang/tk
			x11-libs/libX11
			x11-libs/libXmu ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-curs.patch
	epatch "${FILESDIR}"/${P}-dynamic-linking.patch
	epatch "${FILESDIR}"/${P}-lex.patch
	epatch "${FILESDIR}"/${P}-mercury-glut.patch
	epatch "${FILESDIR}"/${P}-mercury-tcltk.patch
	epatch "${FILESDIR}"/${P}-mercury-opengl.patch
	epatch "${FILESDIR}"/${P}-posix.patch
	epatch "${FILESDIR}"/${P}-no-java-grade-no-erlang-grade.patch

	if use odbc; then
		epatch "${FILESDIR}"/${P}-odbc.patch
	elif use iodbc; then
		epatch "${FILESDIR}"/${P}-iodbc.patch
	fi

	sed -i	-e "s:posix:posix quickcheck:" \
		-e "s:references::" \
		-e "s:windows_installer_generator ::" Mmakefile

	use glut && sed -i -e "s: lex : graphics/mercury_glut lex :" Mmakefile
	use tcl && use tk && sed -i -e "s: lex : graphics/mercury_tcltk lex :" Mmakefile
	use opengl && sed -i -e "s: lex : graphics/mercury_opengl lex :" Mmakefile

	if use odbc || use iodbc; then
		sed -i -e "s:moose:moose odbc:" Mmakefile
	fi

	! use ncurses && sed -i -e "s:curs curses::" Mmakefile
	! use xml && sed -i -e "s:xml::" Mmakefile

	sed -i -e "s:@libdir@:$(get_libdir):" \
		dynamic_linking/Mmakefile posix/Mmakefile

	# disable broken packages
	sed -i  -e "s:lazy_evaluation ::" \
		-e "s:quickcheck::" Mmakefile
}

src_compile() {
	# Mercury dependency generation must be run single-threaded
	mmake \
		-j1 depend || die "mmake depend failed"

	mmake \
		MMAKEFLAGS="${MAKEOPTS}" \
		EXTRA_MLFLAGS=--no-strip \
		EXTRA_LDFLAGS="${LDFLAGS}" \
		EXTRA_LD_LIBFLAGS="${LDFLAGS}" \
		|| die "mmake failed"
}

src_install() {
	mmake \
		MMAKEFLAGS="${MAKEOPTS}" \
		EXTRA_LD_LIBFLAGS="${LDFLAGS}" \
		INSTALL_PREFIX="${D}"/usr \
		install || die "mmake install failed"

	find "${D}"/usr/$(get_libdir)/mercury -type l | xargs rm

	cd "${S}"
	if use examples; then
		insinto /usr/share/doc/${PF}/samples/complex_numbers
		doins complex_numbers/samples/*.m

		if use ncurses; then
			insinto /usr/share/doc/${PF}/samples/curs
			doins curs/samples/*.m

			insinto /usr/share/doc/${PF}/samples/curses
			doins curses/sample/*.m
		fi

		if use X; then
			insinto /usr/share/doc/${PF}/samples/graphics
			doins graphics/easyx/samples/*.m
		fi

		if use glut && use opengl; then
			insinto /usr/share/doc/${PF}/samples/graphics
			doins graphics/samples/calc/*.m
			doins graphics/samples/gears/*.m
			doins graphics/samples/maze/*.m
		fi

		if use opengl && use tcl && use tk; then
			insinto /usr/share/doc/${PF}/samples/graphics
			doins graphics/samples/pent/*.m
		fi

		insinto /usr/share/doc/${PF}/samples/dynamic_linking
		doins dynamic_linking/hello.m

		insinto /usr/share/doc/${PF}/samples/lex
		doins lex/samples/*.m

		insinto /usr/share/doc/${PF}/samples/moose
		doins moose/samples/*.m moose/samples/*.moo
	fi

	dodoc README
}
