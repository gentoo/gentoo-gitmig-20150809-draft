# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/u-vm-color/u-vm-color-1.7.ebuild,v 1.9 2005/05/01 16:47:50 hansmi Exp $

inherit elisp

IUSE=""

DESCRIPTION="Color schemes for VM"
HOMEPAGE="ftp://ftp.cis.ohio-state.edu/pub/emacs-lisp/archive/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/emacs
	app-emacs/vm"

SITEFILE=50u-vm-color-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/u-vm-color.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
