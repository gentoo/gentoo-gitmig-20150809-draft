# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/gotmail/gotmail-0.8.1.ebuild,v 1.1 2003/12/29 17:07:43 g2boojum Exp $

DESCRIPTION="Utility to download mail from a HotMail account"
SRC_URI="mirror://sourceforge/gotmail/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/gotmail/"

RDEPEND="virtual/glibc net-ftp/curl dev-perl/URI dev-perl/libnet"
DEPEND=${RDEPEND}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"

src_compile () {
	echo "nothing to compile"
}

src_install () {
	dobin gotmail
	dodoc COPYING ChangeLog README sample.gotmailrc
	doman gotmail.1
}
