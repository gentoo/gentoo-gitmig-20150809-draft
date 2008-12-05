# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/agda/agda-1.0.2-r2.ebuild,v 1.1 2008/12/05 16:58:17 bicatali Exp $

inherit elisp-common eutils

MY_PN="Agda"
S="${WORKDIR}/${MY_PN}-${PV}"

DESCRIPTION="Proof assistant in Haskell"
HOMEPAGE="http://unit.aist.go.jp/cvs/Agda/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs"

RDEPEND="emacs? ( virtual/emacs app-emacs/haskell-mode )"
DEPEND="${RDEPEND}
	dev-lang/ghc
	dev-haskell/mtl"

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-make_install.patch
	epatch "${FILESDIR}"/${P}-upstream-fixes.patch

	sed -e "s:-package lang::" -i src/Makefile.in \
		|| die "Failed to fix Makfile.in"
}

src_compile() {
	econf --enable-newsyntax
	emake || die "emake failed"
	#if use doc ; then
	#	emake html
	#fi
}

src_install() {
	emake -C src ROOT="${D}" install || die "make install failed"
	dosym /usr/lib/EmacsAgda/bin/emacsagda /usr/bin/emacsagda
	dosym emacsagda /usr/bin/agda

	if use emacs; then
		elisp-install ${PN} elisp/agda-mode.el || die
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
