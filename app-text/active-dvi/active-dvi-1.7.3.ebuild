# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/active-dvi/active-dvi-1.7.3.ebuild,v 1.7 2008/10/05 10:33:16 aballier Exp $

EAPI=1

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

RDEPEND=">=dev-lang/ocaml-3.10.0
	>=dev-ml/camlimages-2.20-r2
	virtual/latex-base
	virtual/ghostscript
	x11-libs/libXinerama"
DEPEND="${RDEPEND}
	|| ( ( dev-texlive/texlive-pstricks dev-texlive/texlive-pictures ) app-text/tetex app-text/ptex )
	x11-proto/xineramaproto
	dev-ml/findlib
	dev-tex/hevea"

DOCS="README TODO"

pkg_setup() {
	# warn those who have USE="tk" but no ocaml tk support
	# because we cant force ocaml to be build with tk.
	if use tk; then
		if [ ! -d /usr/lib/ocaml/labltk ]; then
			echo ""
			ewarn "You have requested tk support, but it appears"
			ewarn "your ocaml wasnt compiled with tk support, "
			ewarn "so it can't be included for active-dvi."
			echo ""
			ewarn "Please stop this build, and emerge ocaml with "
			ewarn "USE=\"tk\" ocaml"
			ewarn "before emerging active-dvi if you want tk support."
			echo ""
			# give the user some time to read this, but leave the
			# choice up to them
			epause 8
		fi
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
	epatch "${FILESDIR}/${P}-asneeded.patch"
	AT_M4DIR="." eautoreconf
}

src_compile() {
	export ADVI_LOC="/usr/share/texmf/tex/latex/advi"
	econf $(use_enable ocamlopt native-program)
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
