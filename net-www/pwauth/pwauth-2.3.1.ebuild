# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/pwauth/pwauth-2.3.1.ebuild,v 1.1 2005/02/17 10:28:57 hollow Exp $

inherit eutils

DESCRIPTION="A Unix Web Authenticator"
HOMEPAGE="http://www.unixpapa.com/pwauth/"
SRC_URI="http://www.unixpapa.com/software/${P}.tar.gz"

DEPEND="sys-libs/pam"
LICENSE="Apache-1.1"
KEYWORDS="~x86"
IUSE=""
SLOT="0"

src_install() {
	dosbin pwauth unixgroup
	insinto /etc/pam.d/
	newins ${FILESDIR}/pwauth.pam pwauth
	dodoc CHANGES FORM_AUTH INSTALL README
}