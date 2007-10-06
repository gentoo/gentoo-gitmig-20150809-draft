# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/u-vm-color/u-vm-color-1.7.ebuild,v 1.12 2007/10/06 17:38:43 ulm Exp $

inherit elisp

DESCRIPTION="Color schemes for VM"
HOMEPAGE="ftp://ftp.cis.ohio-state.edu/pub/emacs-lisp/archive/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="app-emacs/vm"

SITEFILE=50${PN}-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}

pkg_postinst() {
	elisp-site-regen
	elog "Please see ${SITELISP}/${PN}/u-vm-color.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
