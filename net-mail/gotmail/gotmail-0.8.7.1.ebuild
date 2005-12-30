# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/gotmail/gotmail-0.8.7.1.ebuild,v 1.2 2005/12/30 12:04:15 mcummings Exp $

inherit eutils

DESCRIPTION="Utility to download mail from a HotMail account"
HOMEPAGE="http://sourceforge.net/projects/gotmail"
SRC_URI="mirror://sourceforge/gotmail/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	net-misc/curl
	dev-perl/URI
	perl-core/libnet
	app-arch/gzip"

src_compile() {
	make || die
}

src_install() {
	dobin gotmail || die
	dodoc ChangeLog README sample.gotmailrc
	doman gotmail.1.gz
}
