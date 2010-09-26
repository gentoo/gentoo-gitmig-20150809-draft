# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/cone/cone-0.84.ebuild,v 1.1 2010/09/26 04:47:07 radhermit Exp $

EAPI="2"

DESCRIPTION="CONE: COnsole News reader and Emailer"
HOMEPAGE="http://www.courier-mta.org/cone/"
SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="crypt fam gnutls idn ipv6 ldap spell"

RDEPEND=">=dev-libs/openssl-0.9.6
	dev-libs/libxml2
	sys-libs/ncurses
	crypt? ( >=app-crypt/gnupg-1.0.4 )
	fam? ( virtual/fam )
	gnutls? ( net-libs/gnutls )
	idn? ( net-dns/libidn )
	ipv6? ( net-dns/libidn )
	ldap? ( net-nds/openldap )
	spell? ( virtual/aspell-dict )"
DEPEND="${RDEPEND}
	dev-lang/perl"

src_configure() {
	econf \
		$(use_with ldap ldapaddressbook) \
		$(use_with gnutls) \
		$(use_with idn libidn) \
		$(use_with ipv6)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	emake DESTDIR="${D}" install-configure || die "emake install-configure failed"
}
