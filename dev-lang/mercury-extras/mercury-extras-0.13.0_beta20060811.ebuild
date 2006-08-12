# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mercury-extras/mercury-extras-0.13.0_beta20060811.ebuild,v 1.1 2006/08/12 21:33:37 keri Exp $

inherit eutils versionator

BETA_V=$(get_version_component_range 4 $PV)
BETA_V_YYYY=${BETA_V:4:4}
BETA_V_MM=${BETA_V:8:2}
BETA_V_DD=${BETA_V:10:2}
MY_PV=$(get_version_component_range 1-3 $PV)-beta-${BETA_V_YYYY}-${BETA_V_MM}-${BETA_V_DD}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Additional libraries and tools that are not part of the Mercury standard library"
HOMEPAGE="http://www.cs.mu.oz.au/research/mercury/index.html"
SRC_URI="ftp://ftp.mercury.cs.mu.oz.au/pub/mercury/beta-releases/0.13.0-beta/${MY_P}-unstable.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

IUSE="doc glut iodbc odbc opengl tcltk"

DEPEND="~dev-lang/mercury-${PV}
	sys-libs/ncurses
	glut? ( virtual/glut )
	odbc? ( dev-db/unixODBC )
	iodbc? ( !odbc? ( dev-db/libiodbc ) )
	opengl? ( virtual/opengl )
	tcltk? ( =dev-lang/tk-8.4*
		|| ( (
			x11-libs/libX11
			x11-libs/libXmu )
		virtual/x11 ) )"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-concurrency-r1.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-dynamic_linking.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-lex.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-mercury_glut.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-mercury_tcltk.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-mercury_opengl.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-odbc-r1.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-posix.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-references.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-trailed_update-r1.patch

	sed -i	-e "s:curs:concurrency curs:" \
		-e "s:posix:posix quickcheck:" \
		-e "s:windows_installer_generator ::" Mmakefile
	sed -i  -e "s:lib/mercury:lib/mercury-${PV}:" posix/Mmakefile

	if built_with_use dev-lang/mercury minimal; then
		sed -i -e "s:references::" Mmakefile
	else
		sed -i -e "s:xml:trailed_update xml:" Mmakefile
	fi

	use glut && sed -i -e "s: lex : graphics/mercury_glut lex :" Mmakefile
	use tcltk && sed -i -e "s: lex : graphics/mercury_tcltk lex :" Mmakefile
	use opengl && sed -i -e "s: lex : graphics/mercury_opengl lex :" Mmakefile

	if use odbc ; then
		sed -i -e "s:moose:moose odbc:" Mmakefile
	elif use iodbc ; then
		sed -i -e "s:moose:moose odbc:" Mmakefile
		sed -i -e "s:MODBC_DRIVER=MODBC_UNIX:MODBC_DRIVER=MODBC_IODBC:" odbc/Mmakefile
	fi
}

src_compile() {
	mmake depend || die "mmake depend failed"
	mmake || die "mmake failed"

	if use opengl && use tcltk ; then
		cd "${S}"/graphics/mercury_opengl
		cp ../mercury_tcltk/mtcltk.m ./
		mmake -f Mmakefile.mtogl depend || die "mmake depend mtogl failed"
		mmake -f Mmakefile.mtogl || die "mmake mtogl failed"
	fi
}

src_install() {
	cd "${S}"
	mmake INSTALL_PREFIX="${D}"/usr install || die "mmake install failed"

	if use opengl && use tcltk ; then
		cd "${S}"/graphics/mercury_opengl
		mv Mmakefile Mmakefile.opengl
		mv Mmakefile.mtogl Mmakefile
		mmake INSTALL_PREFIX="${D}"/usr \
			install || die "mmake install mtogl failed"
	fi

	cd "${S}"
	if use doc ; then
		docinto samples/complex_numbers
		dodoc complex_numbers/samples/*.m

		docinto samples/curs
		dodoc curs/samples/*.m

		docinto samples/curses
		dodoc curses/sample/*.m

		docinto samples/dynamic_linking
		dodoc dynamic_linking/hello.m

		docinto samples/lex
		dodoc lex/samples/*.m

		docinto samples/moose
		dodoc moose/samples/*.m moose/samples/*.moo

		docinto samples/references
		dodoc references/samples/*.m
	fi

	dodoc README
}
