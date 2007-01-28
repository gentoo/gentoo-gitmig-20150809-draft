# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/u-vm-color/u-vm-color-2.8.ebuild,v 1.4 2007/01/28 04:35:32 genone Exp $

inherit elisp

DESCRIPTION="Color schemes for VM"
HOMEPAGE="http://de.geocities.com/ulf_jasper/emacs.html#vm"
SRC_URI="http://de.geocities.com/ulf_jasper/lisp/${PN}.el.txt"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/emacs
	app-emacs/vm"

SITEFILE=51u-vm-color-gentoo.el

src_unpack() {
	einfo "Copying file into ${S}..."

	mkdir -p ${S}
	cp ${DISTDIR}/${PN}.el.txt ${S}/${PN}.el || die
}

src_compile() {
	elisp-compile ${PN}.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	elog "Please see ${SITELISP}/${PN}/${PN}.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
