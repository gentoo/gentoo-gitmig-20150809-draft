# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/epix/epix-1.2.8.ebuild,v 1.2 2011/07/27 21:51:05 bicatali Exp $

EAPI=4
inherit elisp-common bash-completion autotools

DESCRIPTION="2- and 3-D plotter for creating images (to be used in LaTeX)"
HOMEPAGE="http://mathcs.holycross.edu/~ahwang/current/ePiX.html"
SRC_URI="http://mathcs.holycross.edu/~ahwang/epix/${P}_withpdf.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc emacs examples"

DEPEND="virtual/latex-base
		|| ( ( dev-texlive/texlive-pstricks
			   dev-texlive/texlive-pictures
			   dev-texlive/texlive-latexextra
			   dev-tex/xcolor )
			app-text/ptex )
		emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}"
SITEFILE=50${PN}-gentoo.el

src_prepare() {
	# disable automatic install of doc and examples
	epatch "${FILESDIR}"/${PN}-1.2.7-doc-gentoo.patch
	eautoreconf
}

src_configure() {
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--disable-epix-el
}

src_install() {
	default
	if use emacs; then
		# do compilation here as the make install target will
		# create the .el file
		elisp-compile *.el || die "elisp-compile failed!"
		elisp-install ${PN} *.elc *.el || die "elisp-install failed!"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
	dobashcompletion bash_completions
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins doc/*gz
	fi
	if use examples; then
		cd samples
		insinto /usr/share/doc/${PF}/examples
		doins *.xp *.flx *c *h README
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
