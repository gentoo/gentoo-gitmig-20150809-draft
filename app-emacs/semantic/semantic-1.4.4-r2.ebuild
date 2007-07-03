# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/semantic/semantic-1.4.4-r2.ebuild,v 1.2 2007/07/03 07:26:15 opfer Exp $

inherit elisp

DESCRIPTION="The Semantic Bovinator is a lexer, parser-generator, and parser written in Emacs Lisp"
HOMEPAGE="http://cedet.sourceforge.net/semantic.shtml"
SRC_URI="mirror://sourceforge/cedet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=app-emacs/speedbar-0.14_beta4
	>=app-emacs/eieio-0.17
	!app-emacs/cedet"

SITEFILE=61${PN}-gentoo.el

src_compile() {
	emake LOADPATH="${SITELISP}/speedbar ${SITELISP}/eieio" || die
}

src_install() {
	elisp-install ${PN} *.el *.elc *.bnf
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc ChangeLog NEWS INSTALL
	doinfo semantic.info*
}
