# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/matlab/matlab-2.2.3.ebuild,v 1.9 2005/04/05 15:55:38 blubb Exp $

inherit elisp

IUSE=""

DESCRIPTION="Major modes for MATLAB dot-m and dot-tlc files"
HOMEPAGE="ftp://ftp.mathworks.com/pub/contrib/emacs_add_ons/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~amd64"

DEPEND="virtual/emacs"

SITEFILE=50matlab-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/ for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
