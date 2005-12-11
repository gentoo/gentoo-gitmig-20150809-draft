# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/ldapvi/ldapvi-1.4-r1.ebuild,v 1.1 2005/12/11 13:59:10 lcars Exp $

inherit eutils

DESCRIPTION="Manage LDAP entries with a text editor"
HOMEPAGE="http://www.lichteblau.com/src.html"
SRC_URI="http://www.lichteblau.com/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~hppa"

DEPEND="sys-libs/ncurses
		>=net-nds/openldap-2.2
		dev-libs/popt
		>=dev-libs/glib-2"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}"/ldapvi-filter.diff
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dobin ldapvi
	doman ldapvi.1
}
