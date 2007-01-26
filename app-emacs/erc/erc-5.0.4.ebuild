# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erc/erc-5.0.4.ebuild,v 1.2 2007/01/26 08:23:41 opfer Exp $

inherit elisp

DESCRIPTION="The Emacs IRC Client"
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?EmacsIRCClient"
SRC_URI="mirror://sourceforge/erc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86 ~amd64"
IUSE=""
SITEFILE=50erc-gentoo.el

DEPEND="virtual/emacs"

S="${WORKDIR}/${P/_*/}"

src_compile() {
	make || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc AUTHORS CREDITS HISTORY ChangeLog servers.pl README
}
