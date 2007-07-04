# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/pymacs/pymacs-0.22-r1.ebuild,v 1.12 2007/07/04 23:18:24 opfer Exp $

inherit distutils elisp eutils

DESCRIPTION="A tool that allows both-side communication beetween Python and Emacs-lisp"
HOMEPAGE="http://pymacs.progiciels-bpi.ca/"
SRC_URI="http://pymacs.progiciels-bpi.ca/archives/${P/pymacs/Pymacs}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ia64 ppc ppc-macos s390 sh x86 ~x86-fbsd"
IUSE="doc"

DEPEND="virtual/python"
SITEFILE=50${PN}-gentoo.el

S=${WORKDIR}/Pymacs-${PV}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-character-encoding-gentoo.patch
}

src_compile() {
	distutils_src_compile
	elisp-compile pymacs.el
}

src_install() {
	elisp-install ${PN} pymacs.el pymacs.elc
	elisp-site-file-install "${FILESDIR}"/
	distutils_src_install
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins ./pymacs.pdf
	fi
	cd "${S}"
	dodoc THANKS THANKS-rebox
}
