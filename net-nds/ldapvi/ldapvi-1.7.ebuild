# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/ldapvi/ldapvi-1.7.ebuild,v 1.4 2008/01/07 22:43:44 omp Exp $

inherit eutils

DESCRIPTION="Manage LDAP entries with a text editor"
HOMEPAGE="http://www.lichteblau.com/ldapvi/"
SRC_URI="http://www.lichteblau.com/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE="ssl"

RDEPEND="sys-libs/ncurses
	>=net-nds/openldap-2.2
	dev-libs/popt
	>=dev-libs/glib-2
	sys-libs/readline
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf $(use_with ssl libcrypto openssl) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dobin ldapvi || "dobin failed"
	doman ldapvi.1
}
