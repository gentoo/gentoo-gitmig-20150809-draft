# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erc/erc-5.2.ebuild,v 1.1 2007/04/10 20:57:42 opfer Exp $

inherit elisp

DESCRIPTION="The Emacs IRC Client"
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?EmacsIRCClient"
SRC_URI="mirror://gnu/erc/erc-${PV}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86 ~amd64"
IUSE=""
SITEFILE=50erc-gentoo.el

S="${WORKDIR}/${P/_*/}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc AUTHORS ChangeLog* CREDITS HISTORY servers.pl README
	doinfo *.info*
}
