# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/ldapvi/ldapvi-1.7-r1.ebuild,v 1.2 2011/06/14 00:05:15 xmw Exp $

EAPI=2

inherit eutils

DESCRIPTION="Manage LDAP entries with a text editor"
HOMEPAGE="http://www.lichteblau.com/ldapvi/"
SRC_URI="http://www.lichteblau.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="ssl"

RDEPEND="sys-libs/ncurses
	>=net-nds/openldap-2.2
	dev-libs/popt
	>=dev-libs/glib-2
	sys-libs/readline
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${P}+glibc-2.10.patch"
	epatch "${FILESDIR}/${P}-vim-encoding.patch"
}

src_configure() {
	econf $(use_with ssl libcrypto openssl) || die
}

src_install() {
	dobin ldapvi || die
	doman ldapvi.1 || die
	dodoc NEWS manual/{bg.png,html.xsl,manual.{css,xml}} || die
}
