# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/remember/remember-1.9.ebuild,v 1.7 2007/04/23 15:49:17 ulm Exp $

inherit elisp

DESCRIPTION="Simplify writing short notes in emacs"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/RememberMode"
SRC_URI="http://download.gna.org/remember-el/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="app-emacs/bbdb"
DEPEND="${RDEPEND}"

SITEFILE=50${PN}-gentoo.el

src_compile() {
	emake || die "emake failed"
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	doinfo remember-el.info
	dodoc ChangeLog
}
