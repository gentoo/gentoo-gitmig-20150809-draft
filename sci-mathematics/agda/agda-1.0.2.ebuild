# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/agda/agda-1.0.2.ebuild,v 1.4 2008/07/26 11:37:35 markusle Exp $

inherit elisp-common eutils

MY_PN="Agda"
S="${WORKDIR}/${MY_PN}-${PV}"

DESCRIPTION="Agda is a proof assistant in Haskell."
HOMEPAGE="http://unit.aist.go.jp/cvs/Agda/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc emacs"

DEPEND="dev-lang/ghc
		emacs? ( virtual/emacs )
		doc? ( dev-haskell/haddock )"
RDEPEND=""

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/agda-make_install.patch"
}

src_compile() {
	econf --enable-newsyntax || die "./configure failed"
	emake || die "make failed"
	if use doc ; then
		emake html
	fi
}

src_install() {
	if use emacs; then
		cd "${S}"/elisp
		elisp-install ${PN} *.el
		elisp-site-file-install "${FILESDIR}"/${SITEFILE}
	fi
	cd "${S}"/src
	make prefix="${D}"/usr install || die "make install failed"
	dosym /usr/lib/EmacsAgda/bin/emacsagda /usr/bin/emacsagda
	dosym /usr/bin/emacsagda /usr/bin/agda

}

pkg_postinst() {
	if use emacs; then
		elisp-site-regen
	fi
}
