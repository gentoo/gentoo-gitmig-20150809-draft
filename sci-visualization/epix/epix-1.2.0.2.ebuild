# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/epix/epix-1.2.0.2.ebuild,v 1.3 2008/01/11 14:42:56 markusle Exp $

inherit elisp-common flag-o-matic toolchain-funcs bash-completion

MY_PV="${PV/%.2/-2}"

DESCRIPTION="2- and 3-D plotter for creating images (to be used in LaTeX)"
HOMEPAGE="http://mathcs.holycross.edu/~ahwang/current/ePiX.html"
SRC_URI="http://mathcs.holycross.edu/~ahwang/epix/${PN}-${MY_PV}_withpdf.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="emacs"

DEPEND="virtual/tetex
		emacs? ( virtual/emacs )"

SITEFILE=50${PN}-gentoo.el

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.1.17-doc-gentoo.patch
	sed -e 's:doc/${PACKAGE_TARNAME}:doc/${PACKAGE_TARNAME}-${PACKAGE_VERSION}:' \
	-i configure || die "sed on configure failed"
}

src_compile() {
	econf --with-nolisp || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	if use emacs; then
		# do compilation here as the make install target will
		# create the .el file
		elisp-compile *.el || die "elisp-compile failed!"
		elisp-install ${PN} *.elc *.el || die "elisp-install failed!"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
	dobashcompletion bash_completions \
		|| die "install of bash completions failed"
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
