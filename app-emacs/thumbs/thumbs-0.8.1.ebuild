# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/thumbs/thumbs-0.8.1.ebuild,v 1.7 2004/07/14 01:07:52 agriffis Exp $

inherit elisp

IUSE=""

DESCRIPTION="Emacs thumbnail previewer for image files"
HOMEPAGE="http://aroy.net/emacslisp.org/mypackages/thumbs/thumbs.el"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs
	media-gfx/imagemagick"


SITEFILE=50thumbs-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/thumbs.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
