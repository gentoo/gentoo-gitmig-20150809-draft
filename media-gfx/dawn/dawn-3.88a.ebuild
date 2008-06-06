# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/dawn/dawn-3.88a.ebuild,v 1.1 2008/06/06 19:26:12 bicatali Exp $

#EAPI=0
inherit eutils versionator

MYP=${PN}_$(replace_version_separator 1 _)

DESCRIPTION="3D geometrical postscript renderer"
HOMEPAGE="http://geant4.kek.jp/~tanaka/DAWN/About_DAWN.html"
SRC_URI="http://geant4.kek.jp/~tanaka/src/${MYP}.taz"

LICENSE="public-domain"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="doc opengl X"

RDEPEND="dev-lang/tk
	X? ( x11-libs/libX11 )
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	app-shells/tcsh
	doc? ( virtual/latex-base )"

S="${WORKDIR}/${MYP}"

src_unpack() {
	# unpack does not recognize taz suffix
	tar xfz "${DISTDIR}"/${MYP}.taz
	cd "${S}"
	epatch "${FILESDIR}"/${P}-no-interactive.patch
	sed -i -e '/strip/d' Makefile*in || die "sed Makefile failed"
}

src_compile() {
	emake clean
	emake guiclean
	if ! use X && ! use opengl; then
		./configure_min || die "configure failed"
	elif ! use opengl; then
		./configure_xwin || die "configure_xwin failed"
	else
		./configure || die "configure failed"
	fi
	einfo "Compiling"
	emake  || die "emake failed"
}

src_install() {
	dodir /usr/bin
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README.txt
	if use doc; then
		pdflatex DOC/G4PRIM_FORMAT_24.tex || die "pdf generation failed"
		insinto /usr/share/doc/${PF}
		doins DOC/G4PRIM_FORMAT_24.pdf
		dohtml DOC/*.html
	fi
}
