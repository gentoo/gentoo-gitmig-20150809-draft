# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erc/erc-2.93.ebuild,v 1.1 2002/11/01 02:52:01 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="ERC - The Emacs IRC Client"
SRC_URI="mirror://sourceforge/erc/${P}.tar.gz"
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?EmacsIRCClient"

DEPEND="virtual/emacs"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

S=${WORKDIR}/${P}

src_install() {	
	elisp-install ${PN} *.el
	elisp-site-file-install ${FILESDIR}/50erc-gentoo.el
	dodoc CREDITS HISTORY ChangeLog servers.pl TODO
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
