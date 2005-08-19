# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/haskell-mode/haskell-mode-2.0.ebuild,v 1.1 2005/08/19 03:12:17 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="Mode for editing (and running) Haskell programs in Emacs"
HOMEPAGE="http://www.haskell.org/haskell-mode/
	http://www.iro.umontreal.ca/~monnier/elisp/"
SRC_URI="http://www.iro.umontreal.ca/~monnier/elisp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

SITEFILE="50${PN}-gentoo.el"

# src_unpack() {
#	unpack ${A}
#	cp ${S}/.emacs ${S}/${SITEFILE}
#	sed -i 's,~/lib/emacs,@SITELISP@,' ${S}/${SITEFILE} || die
# }

src_compile() {
	elisp-comp *.el || die
}

src_install() {
	elisp-install ${PN} *.{el,elc}
#	elisp-site-file-install ${SITEFILE}
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	dohtml *.html *.hs
	dodoc ChangeLog NEWS
	insinto /usr/share/doc/${PF}
	doins *.hs
}

pkg_postinst() {
	elisp_pkg_postinst
	einfo "See /usr/share/doc/${PF}/html/installation-guide.html"
}
