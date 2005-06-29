# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erc/erc-5.0.3.ebuild,v 1.2 2005/06/29 17:48:01 mkennedy Exp $

inherit elisp

DESCRIPTION="ERC - The Emacs IRC Client"
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?EmacsIRCClient"
SRC_URI="mirror://sourceforge/erc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86 ~amd64"
IUSE=""

DEPEND="virtual/emacs"

S=${WORKDIR}/${P/_*/}

src_compile() {
	make || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${PV}/50erc-gentoo.el
	dodoc AUTHORS CREDITS HISTORY ChangeLog servers.pl README
}
