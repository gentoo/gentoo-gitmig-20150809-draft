# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/postal/postal-0.62.ebuild,v 1.2 2005/01/08 10:10:55 swegener Exp $

DESCRIPTION="SMTP and POP mailserver benchmark - the mad postman. Supports SSL, randomized user accounts and more."
HOMEPAGE="http://www.coker.com.au/postal/"
SRC_URI="http://www.coker.com.au/postal/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE="ssl"
DEPEND="ssl? ( >=dev-libs/openssl-0.9.6b )"

src_compile() {
	econf $(use_enable ssl) || die
	emake || die
}

src_install() {
	dosbin postal postal-list rabid
	doman postal-list.8 postal.8 rabid.8
}
