# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mercury-extras/mercury-extras-0.13.1-r1.ebuild,v 1.6 2011/02/12 18:29:05 armin76 Exp $

inherit eutils

DESCRIPTION="Additional libraries and tools that are not part of the Mercury standard library"
HOMEPAGE="http://www.cs.mu.oz.au/research/mercury/index.html"
SRC_URI="ftp://ftp.mercury.cs.mu.oz.au/pub/mercury/mercury-extras-0.13.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE="examples glut iodbc ncurses odbc opengl tcl tk xml"

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
	epatch "${FILESDIR}"/${P}-dynamic_linking.patch
	epatch "${FILESDIR}"/${P}-lex.patch
	epatch "${FILESDIR}"/${P}-mercury_glut.patch
	epatch "${FILESDIR}"/${P}-mercury_tcltk.patch
	epatch "${FILESDIR}"/${P}-mercury_opengl.patch
	epatch "${FILESDIR}"/${P}-posix.patch

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
}

src_compile() {
	mmake \
		-j1 depend || die "mmake depend failed"
	mmake \
		MMAKEFLAGS="${MAKEOPTS}" \
		EXTRA_MLFLAGS=--no-strip \
		|| die "mmake failed"

	if use opengl && use tcl && use tk; then
		cd "${S}"/graphics/mercury_opengl
		cp ../mercury_tcltk/mtcltk.m ./
		mmake \
			-f Mmakefile.mtogl \
			-j1 depend || die "mmake depend mtogl failed"
		mmake \
			MMAKEFLAGS="${MAKEOPTS}" \
			-f Mmakefile.mtogl \
			|| die "mmake mtogl failed"
	fi
}

src_install() {
	mmake \
		MMAKEFLAGS="${MAKEOPTS}" \
		INSTALL_PREFIX="${D}" \
		install || die "mmake install failed"

	if use opengl && use tcl && use tk; then
		cd "${S}"/graphics/mercury_opengl
		mv Mmakefile Mmakefile.opengl
		mv Mmakefile.mtogl Mmakefile
		mmake \
			MMAKEFLAGS="${MAKEOPTS}" \
			INSTALL_PREFIX="${D}" \
			install || die "mmake install mtogl failed"
	fi

	find "${D}"/usr/lib/mercury-${PV} -type l | xargs rm

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

		insinto /usr/share/doc/${PF}/samples/dynamic_linking
		doins dynamic_linking/hello.m

		insinto /usr/share/doc/${PF}/samples/lex
		doins lex/samples/*.m

		insinto /usr/share/doc/${PF}/samples/moose
		doins moose/samples/*.m moose/samples/*.moo
	fi

	dodoc README
}
