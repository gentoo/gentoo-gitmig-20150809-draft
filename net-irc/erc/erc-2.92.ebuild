# Copyriht 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-irc/erc/erc-2.92.ebuild,v 1.3 2002/07/11 06:30:46 drobbins Exp $

LICENSE="GPL-2"

S=${WORKDIR}/erc
DESCRIPTION="ERC - The Emacs IRC Client"
SRC_URI="mirror://sourceforge/erc/${P}.tar.gz"
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?EmacsIRCClient"

DEPEND=""
RDEPEND=">=app-editors/emacs-21.2"

src_install() {	
	dodoc CREDITS HISTORY ChangeLog servers.pl
	insinto /usr/share/emacs/21.2/lisp
	doins *.el
}
