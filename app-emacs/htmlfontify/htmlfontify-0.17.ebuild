# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/htmlfontify/htmlfontify-0.17.ebuild,v 1.8 2005/07/01 18:39:22 mkennedy Exp $

inherit elisp

IUSE=""

MY_P=${PN}_${PV}+texinfo
S=${WORKDIR}/${MY_P/_/-}
DESCRIPTION="Turn an Emacs buffer into display-equivalent HTML"
HOMEPAGE="http://rtfm.etla.org/emacs/htmlfontify/"
SRC_URI="http://rtfm.etla.org/emacs/htmlfontify/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"

DEPEND="virtual/emacs"


SITEFILE=50htmlfontify-gentoo.el

src_compile() {
	elisp-compile *.el
	makeinfo htmlfontify.texi
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	dodoc LICENSE
	doinfo htmlfontify.info
}
