# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erc/erc-5.2-r1.ebuild,v 1.5 2008/01/25 23:05:53 opfer Exp $

inherit elisp

DESCRIPTION="The Emacs IRC Client"
HOMEPAGE="http://savannah.gnu.org/projects/erc/
	http://emacswiki.org/cgi-bin/wiki.pl?EmacsIRCClient"
SRC_URI="mirror://gnu/erc/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

SITEFILE=51${PN}-gentoo.el

src_compile() {
	# force regeneration of autoload file by the proper Emacs version
	rm -f erc-auto.el
	emake || die "emake failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc AUTHORS ChangeLog* CREDITS HISTORY servers.pl README
	doinfo *.info*
}
