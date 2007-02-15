# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tdtd/tdtd-0.7.1-r1.ebuild,v 1.2 2007/02/15 17:45:20 opfer Exp $

inherit elisp

IUSE=""

DESCRIPTION="Emacs Major Mode for SGML and XML DTDs"
HOMEPAGE="http://www.menteith.com/tdtd/"
SRC_URI="http://www.menteith.com/tdtd/data/${PN}${PV//./}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

DEPEND="app-arch/unzip"

SITEFILE=50tdtd-gentoo.el

S=${WORKDIR}

src_compile() {
	elisp-comp *.el || die
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc TODO changelog.txt readme.txt tutorial.txt
}
