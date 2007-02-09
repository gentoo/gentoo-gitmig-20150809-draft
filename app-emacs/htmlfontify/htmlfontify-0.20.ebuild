# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/htmlfontify/htmlfontify-0.20.ebuild,v 1.1 2007/02/09 09:39:18 opfer Exp $

inherit elisp

IUSE=""

MY_P=${PN}_${PV}+texinfo
S=${WORKDIR}/${MY_P/_/-}
DESCRIPTION="Turn an Emacs buffer into display-equivalent HTML"
HOMEPAGE="http://rtfm.etla.org/emacs/htmlfontify/"
SRC_URI="http://rtfm.etla.org/emacs/htmlfontify/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=""


SITEFILE=50htmlfontify-gentoo.el

src_compile() {
	elisp-compile *.el
	makeinfo htmlfontify.texi
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc LICENSE
	doinfo htmlfontify.info
}
