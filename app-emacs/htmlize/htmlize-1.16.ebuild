# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/htmlize/htmlize-1.16.ebuild,v 1.6 2005/06/22 01:37:43 weeve Exp $

inherit elisp

IUSE=""

DESCRIPTION="HTML-ize font-lock buffers in Emacs"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?SaveAsHtml
	http://fly.srk.fer.hr/~hniksic/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc x86"

DEPEND="virtual/emacs"

SITEFILE=50htmlize-gentoo.el

# NOTE: this version of htmlize may have issues with emacs-cvs

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/htmlize.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
