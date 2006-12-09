# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erc/erc-5.1.4.ebuild,v 1.1 2006/12/09 21:59:47 mkennedy Exp $

inherit elisp

DESCRIPTION="ERC - The Emacs IRC Client"
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?EmacsIRCClient"
SRC_URI="http://ftp.gnu.org/gnu/erc/erc-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86 ~amd64"
IUSE=""

DEPEND="virtual/emacs
	sys-apps/texinfo"

S=${WORKDIR}/${P/_*/}

src_compile() {
	make || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${PV}/50erc-gentoo.el
	dodoc AUTHORS ChangeLog* CREDITS HISTORY servers.pl README
	doinfo *.info*
}
