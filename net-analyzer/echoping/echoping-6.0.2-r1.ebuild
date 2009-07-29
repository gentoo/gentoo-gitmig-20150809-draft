# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/echoping/echoping-6.0.2-r1.ebuild,v 1.1 2009/07/29 03:09:56 jer Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="echoping is a small program to test performances of remote servers"
HOMEPAGE="http://echoping.sourceforge.net/"
SRC_URI="mirror://sourceforge/echoping/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnutls http icp idn priority smtp ssl tos postgres ldap"
RESTRICT="test"

DEPEND="gnutls? ( >=net-libs/gnutls-1.0.17 )
	ssl? ( >=dev-libs/openssl-0.9.7d )
	idn? ( net-dns/libidn )
	postgres? ( virtual/postgresql-server )
	ldap? ( net-nds/openldap )"

src_prepare() {
	# bug 279525:
	epatch "${FILESDIR}/${P}-gnutls.patch"
	local i
	for i in . plugins/ plugins/*/; do
		cd "${i}"
		eautoreconf
		cd "${S}"
	done
}

src_configure() {
	local my_ssl_conf
	if use gnutls; then
		if use ssl; then
			ewarn "You've enabled both ssl and gnutls USE flags but ${PN} can"
			ewarn "not be built with both, see bug #141782. Using gnutls only."
		fi
		my_ssl_conf="${myconf} $(use_with gnutls)"
	elif use ssl; then
		my_ssl_conf="${myconf} $(use_with ssl)"
	fi

	econf \
		--config-cache \
		--disable-ttcp \
		${my_ssl_conf} \
		$(use_enable http)  \
		$(use_enable icp) \
		$(use_with idn libidn) \
		$(use_enable smtp) \
		$(use_enable tos) \
		$(use_enable priority) \
		|| die "econf failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	# They are not installed by make install
	dodoc README AUTHORS ChangeLog DETAILS NEWS TODO
}
