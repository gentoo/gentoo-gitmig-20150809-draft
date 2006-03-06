# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/rnc-mode/rnc-mode-1.0_beta3.ebuild,v 1.1 2006/03/06 07:27:51 mkennedy Exp $

inherit elisp

MY_PV=${PV/./_}
MY_PV=${MY_PV/_beta/b}

IUSE=""

DESCRIPTION="An Emacs mode for editing Relax NG compact schema files."
HOMEPAGE="http://www.pantor.com/"
SRC_URI="http://www.pantor.com/RncMode-${MY_PV}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"

DEPEND="virtual/emacs"

SITEFILE=50rnc-mode-gentoo.el

S=${WORKDIR}

src_compile() {
	elisp-comp *.el || die
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
