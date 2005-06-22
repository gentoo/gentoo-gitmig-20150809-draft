# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wepdecrypt/wepdecrypt-0.6.ebuild,v 1.3 2005/06/22 15:22:26 dholm Exp $

MY_P="WepDecrypt-${PV}"
DESCRIPTION="Enhanced version of WepAttack a tool for breaking 802.11 WEP keys"
HOMEPAGE="http://wepdecrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/wepdecrypt/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="sys-libs/zlib
	virtual/libpcap
	dev-libs/openssl"

src_install() {
	dobin src/wepdecrypt run/wepdecrypt_{inc,word} || die
	insinto /etc
	doins conf/wepdecrypt.conf
	doman doc/wepdecrypt.1.gz
	dodoc CHANGELOG README doc/manual.html doc/manual.txt
}
