# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/screenie/screenie-1.30.0.ebuild,v 1.6 2008/09/18 14:14:58 jer Exp $

DESCRIPTION="Screenie is a small and lightweight GNU screen(1) frontend that is designed to be a session handler that simplifies the process of administrating detached jobs by providing an interactive menu."
HOMEPAGE="http://pubwww.hsz-t.ch/~mgloor/screenie.html"
SRC_URI="http://pubwww.hsz-t.ch/~mgloor/data/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ia64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="app-misc/screen"

src_install() {
	dobin screenie || die "dobin failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO || die "dodoc failed"
}
