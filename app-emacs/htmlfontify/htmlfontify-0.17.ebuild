# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/htmlfontify/htmlfontify-0.17.ebuild,v 1.5 2004/06/01 14:09:04 vapier Exp $

inherit elisp

IUSE=""

MY_P=${PN}_${PV}+texinfo
S=${WORKDIR}/${MY_P/_/-}
DESCRIPTION="Turn an Emacs buffer into display-equivalent HTML"
HOMEPAGE="http://rtfm.etla.org/emacs/htmlfontify/"
SRC_URI="http://rtfm.etla.org/emacs/htmlfontify/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/emacs"


SITEFILE=50htmlfontify-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
	makeinfo htmlfontify.texi
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc LICENSE
	doinfo htmlfontify.info
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
