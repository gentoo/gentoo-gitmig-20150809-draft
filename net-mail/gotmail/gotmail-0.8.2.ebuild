# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/gotmail/gotmail-0.8.2.ebuild,v 1.1 2004/10/17 12:52:51 axxo Exp $

DESCRIPTION="Utility to download mail from a HotMail account"
HOMEPAGE="http://www.nongnu.org/gotmail/"
SRC_URI="mirror://sourceforge/gotmail/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

DEPEND="virtual/libc
	net-misc/curl
	dev-perl/URI
	dev-perl/libnet"

src_compile () {
	echo "nothing to compile"
}

src_install() {
	dobin gotmail || die
	dodoc ChangeLog README sample.gotmailrc
	doman gotmail.1
}
