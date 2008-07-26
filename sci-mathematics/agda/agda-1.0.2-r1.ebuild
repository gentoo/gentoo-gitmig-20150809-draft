# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/agda/agda-1.0.2-r1.ebuild,v 1.3 2008/07/26 11:37:35 markusle Exp $

inherit elisp-common eutils

MY_PN="Agda"
S="${WORKDIR}/${MY_PN}-${PV}"

DESCRIPTION="Agda is a proof assistant in Haskell."
HOMEPAGE="http://unit.aist.go.jp/cvs/Agda/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="emacs"

DEPEND="dev-lang/ghc
		dev-haskell/mtl
		emacs? ( virtual/emacs )"
RDEPEND=""

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
	econf --enable-newsyntax || die "./configure failed"
	emake -j1 || die "make failed"
	#if use doc ; then
	#	emake html
	#fi
}

src_install() {
	emake ROOT="${D}" install || die "make install failed"
	dosym /usr/lib/EmacsAgda/bin/emacsagda /usr/bin/emacsagda
	dosym /usr/bin/emacsagda /usr/bin/agda

	if use emacs; then
		cd "${S}/elisp"
		elisp-install ${PN} *.el
		elisp-site-file-install "${FILESDIR}"/${SITEFILE}
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
