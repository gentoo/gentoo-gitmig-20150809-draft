# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/active-dvi/active-dvi-1.8.ebuild,v 1.2 2009/11/27 12:43:23 fauli Exp $

EAPI="2"

inherit eutils autotools

MY_PN=${PN/ctive-/}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A DVI previewer and a presenter for slides written in LaTeX"
SRC_URI="http://pauillac.inria.fr/advi/${MY_P}.tar.gz"
HOMEPAGE="http://pauillac.inria.fr/advi/"
LICENSE="LGPL-2.1"

IUSE="+ocamlopt tk"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

RDEPEND=">=dev-lang/ocaml-3.10.0[ocamlopt?,tk?]
	>=dev-ml/camlimages-3.0.1[truetype,tiff,jpeg,gs]
	virtual/latex-base
	virtual/ghostscript
	x11-libs/libXinerama"
DEPEND="${RDEPEND}
	|| ( ( dev-texlive/texlive-pstricks dev-texlive/texlive-pictures )
		app-text/ptex )
	x11-proto/xineramaproto
	dev-ml/findlib
	dev-tex/hevea"

DOCS="README TODO"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.7.3-asneeded.patch"
	AT_M4DIR="." eautoreconf
}

src_configure() {
	export ADVI_LOC="/usr/share/texmf/tex/latex/advi"
	econf $(use_enable ocamlopt native-program)
}

src_compile() {
	emake || die "emake failed"
	cd doc
	VARTEXFONTS="${T}/fonts" emake splash.dvi scratch_write_splash.dvi scratch_draw_splash.dvi || die "failed to create documentation"
}

src_install() {
	emake DESTDIR="${D}" PACKAGE="${PF}" install || die

	# now install the documentation
	dodoc ${DOCS}
	cd "${S}"/doc

	insinto /usr/share/texmf/tex/latex/advi
	doins splash.dvi scratch_write_splash.dvi scratch_draw_splash.dvi || die "failed to install splashes"
	export STRIP_MASK="*/bin/advi.byt"
}

pkg_postinst() {
	einfo "Running texhash to complete installation.."
	texhash
}

pkg_postrm() {
	einfo "Running texhash to complete installation.."
	texhash
}
