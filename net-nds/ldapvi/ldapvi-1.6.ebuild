# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/ldapvi/ldapvi-1.6.ebuild,v 1.1 2006/12/02 21:45:28 hansmi Exp $

DESCRIPTION="Manage LDAP entries with a text editor"
HOMEPAGE="http://www.lichteblau.com/ldapvi/"
SRC_URI="http://www.lichteblau.com/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="ssl"

DEPEND="
	sys-libs/ncurses
	>=net-nds/openldap-2.2
	dev-libs/popt
	>=dev-libs/glib-2
	sys-libs/readline
	ssl? ( dev-libs/openssl )
"

src_compile() {
	econf $(use_with ssl libcrypto openssl) || die
	emake || die
}

src_install() {
	dobin ldapvi
	doman ldapvi.1
}
