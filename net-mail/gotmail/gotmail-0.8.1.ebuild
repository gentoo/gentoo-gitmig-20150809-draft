# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/gotmail/gotmail-0.8.1.ebuild,v 1.5 2004/03/24 23:20:22 mholzer Exp $

DESCRIPTION="Utility to download mail from a HotMail account"
SRC_URI="mirror://sourceforge/gotmail/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://www.nongnu.org/gotmail/"

DEPEND="virtual/glibc net-ftp/curl dev-perl/URI dev-perl/libnet"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ~ppc"

src_compile () {
	echo "nothing to compile"
}

src_install () {
	dobin gotmail
	dodoc COPYING ChangeLog README sample.gotmailrc
	doman gotmail.1
}
