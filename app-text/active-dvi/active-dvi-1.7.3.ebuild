# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/active-dvi/active-dvi-1.7.3.ebuild,v 1.9 2009/05/30 07:08:07 ulm Exp $

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
	>=dev-ml/camlimages-2.20-r2
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
	epatch "${FILESDIR}/${P}-asneeded.patch"
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
	emake DESTDIR="${D}" install || die

	# now install the documentation
	dodoc ${DOCS}
	cd "${S}"/doc
	dohtml *.{jpg,gif,css,html}
	insinto /usr/share/doc/${PF}
	doins manual.{dvi,pdf,ps} || die "failed to install documentation"
	# and the manual page
	doman advi.1
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
