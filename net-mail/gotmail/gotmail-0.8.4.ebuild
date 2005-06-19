# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/gotmail/gotmail-0.8.4.ebuild,v 1.1 2005/06/19 20:29:03 ticho Exp $

inherit eutils

DESCRIPTION="Utility to download mail from a HotMail account"
HOMEPAGE="http://sourceforge.net/projects/gotmail"
SRC_URI="mirror://sourceforge/gotmail/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

DEPEND="virtual/libc
	net-misc/curl
	dev-perl/URI
	dev-perl/libnet"

S=${WORKDIR}/${PN}

src_install() {
	make
	dobin gotmail || die
	dodoc ChangeLog README sample.gotmailrc
	doman gotmail.1
}
