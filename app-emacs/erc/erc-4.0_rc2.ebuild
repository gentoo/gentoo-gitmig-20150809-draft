# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erc/erc-4.0_rc2.ebuild,v 1.1 2003/05/02 18:37:58 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="ERC - The Emacs IRC Client"
SRC_URI="http://erc.sf.net/${P/_rc/-rc}.tar.gz"
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?EmacsIRCClient"

DEPEND="virtual/emacs"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

S=${WORKDIR}/${PN}*

src_compile() {
	make || die
}

src_install() {	
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/50erc-gentoo.el
	dodoc AUTHORS CREDITS HISTORY ChangeLog servers.pl README
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
