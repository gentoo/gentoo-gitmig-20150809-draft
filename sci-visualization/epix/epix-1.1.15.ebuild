# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/epix/epix-1.1.15.ebuild,v 1.3 2007/09/11 13:33:20 markusle Exp $

inherit elisp-common flag-o-matic toolchain-funcs

DESCRIPTION="2- and 3-D plotter for creating images (to be used in LaTeX)"
HOMEPAGE="http://mathcs.holycross.edu/~ahwang/current/ePiX.html"
SRC_URI="http://mathcs.holycross.edu/~ahwang/epix/${P}_withpdf.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="emacs"

DEPEND="virtual/tetex
		emacs? ( virtual/emacs )"

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-doc-gentoo.patch
	sed -e 's:doc/${PACKAGE_TARNAME}:doc/${PACKAGE_TARNAME}-${PACKAGE_VERSION}:' \
	-i configure || die "sed on configure failed"
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
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
