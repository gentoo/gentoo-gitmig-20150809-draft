# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erc-cvs/erc-cvs-4.1.ebuild,v 1.8 2006/05/13 04:36:02 dragonheart Exp $

ECVS_SERVER="erc.cvs.sourceforge.net:/cvsroot/erc"
ECVS_MODULE="erc"
ECVS_USER="anonymous"
ECVS_CVS_OPTIONS="-dP"

inherit elisp cvs

S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="ERC - The Emacs IRC Client - CVS"
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?EmacsIRCClient"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

RESTRICT="$RESTRICT nostrip"

DEPEND="virtual/emacs"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	make || die
}

src_install() {
	elisp_src_install
	dodoc AUTHORS CREDITS HISTORY ChangeLog servers.pl README
}
