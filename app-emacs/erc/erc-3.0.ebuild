# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erc/erc-3.0.ebuild,v 1.2 2003/02/13 07:05:34 vapier Exp $

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
	dodoc AUTHORS CREDITS HISTORY ChangeLog servers.pl README
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
