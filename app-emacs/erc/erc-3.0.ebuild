# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erc/erc-3.0.ebuild,v 1.6 2004/06/01 14:09:04 vapier Exp $

inherit elisp

DESCRIPTION="ERC - The Emacs IRC Client"
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?EmacsIRCClient"
SRC_URI="mirror://sourceforge/erc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"

src_install() {
	elisp-install ${PN} *.el
	elisp-site-file-install ${FILESDIR}/50erc-gentoo.el
	dodoc AUTHORS CREDITS HISTORY ChangeLog servers.pl README
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
