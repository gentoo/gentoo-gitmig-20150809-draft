# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/htmlfontify/htmlfontify-0.17.ebuild,v 1.2 2003/02/13 07:06:14 vapier Exp $

inherit elisp

IUSE=""

FUNKY_P=${PN}_${PV}+texinfo

DESCRIPTION="Turn an Emacs buffer into display-equivalent HTML"
HOMEPAGE="mirror://gentoo/${P}.tar.gz"
SRC_URI="http://rtfm.etla.org/emacs/htmlfontify/${FUNKY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"

S="${WORKDIR}/${FUNKY_P/_/-}"

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
