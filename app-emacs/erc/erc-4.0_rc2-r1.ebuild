# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erc/erc-4.0_rc2-r1.ebuild,v 1.1 2003/11/02 21:44:19 jbms Exp $

inherit elisp

DESCRIPTION="ERC - The Emacs IRC Client"
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?EmacsIRCClient"
SRC_URI="http://erc.sf.net/${P/_rc/-rc}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"

S=${WORKDIR}/${P/_*/}

SITEFILE="50erc-gentoo.el"

src_compile() {
	make || die
}

src_install() {
	elisp_src_install
	dodoc AUTHORS CREDITS HISTORY ChangeLog servers.pl README
}
