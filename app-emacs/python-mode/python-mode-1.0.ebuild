# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/python-mode/python-mode-1.0.ebuild,v 1.5 2006/08/19 18:59:07 grobian Exp $

inherit elisp distutils

IUSE=""

DESCRIPTION="An Emacs major mode for editing Python source."
HOMEPAGE="http://sourceforge.net/projects/python-mode/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc ppc-macos x86"

DEPEND="app-emacs/pymacs"

SITEFILE="60python-mode-gentoo.el"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/setup.py ${S}
}

src_compile() {
	distutils_src_compile
	elisp-comp *.el || die
}

src_install() {
	distutils_src_install
	elisp-install python-mode *.{el,elc}
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp_pkg_postinst
	distutils_pkg_postinst
}

pkg_postrm() {
	elisp_pkg_postrm
	distutils_pkg_postrm
}
