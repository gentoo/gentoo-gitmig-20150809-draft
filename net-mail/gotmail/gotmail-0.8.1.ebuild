# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/gotmail/gotmail-0.8.1.ebuild,v 1.6 2004/03/29 01:13:59 vapier Exp $

DESCRIPTION="Utility to download mail from a HotMail account"
HOMEPAGE="http://www.nongnu.org/gotmail/"
SRC_URI="mirror://sourceforge/gotmail/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"

DEPEND="virtual/glibc
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
