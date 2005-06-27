# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/pwauth/pwauth-2.3.1-r2.ebuild,v 1.3 2005/06/27 16:15:51 blubb Exp $

inherit eutils

DESCRIPTION="A Unix Web Authenticator"
HOMEPAGE="http://www.unixpapa.com/pwauth/"
SRC_URI="http://www.unixpapa.com/software/${P}.tar.gz"

DEPEND="virtual/pam"
LICENSE="Apache-1.1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SLOT="0"

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd to $s failed"
	sed -i -e 's:SERVER_UIDS 72:SERVER_UIDS 81:' config.h
}

src_install() {
	dosbin pwauth unixgroup

	newpamd ${FILESDIR}/pwauth.pam-include pwauth

	dodoc CHANGES FORM_AUTH INSTALL README
}
