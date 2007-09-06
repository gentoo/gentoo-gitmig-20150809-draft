# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/echoping/echoping-6.0.2.ebuild,v 1.2 2007/09/06 16:25:35 jokey Exp $

inherit eutils

DESCRIPTION="echoping is a small program to test performances of remote servers"
HOMEPAGE="http://echoping.sourceforge.net/"
SRC_URI="mirror://sourceforge/echoping/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="gnutls http icp idn priority smtp ssl tos postgres ldap"

DEPEND="gnutls? ( >=net-libs/gnutls-1.0.17 )
	ssl? ( >=dev-libs/openssl-0.9.7d )
	idn? ( net-dns/libidn )
	postgres? ( dev-db/postgresql )
	ldap? ( net-nds/openldap )"

pkg_setup() {
	# bug 141782 - conflicting USE flags - ssl and gnutls
	if use ssl && use gnutls ; then
		eerror "You cannot emerge net-analyzer/echoping with both"
		eerror "ssl and gnutls USE flags set. Please choose one."
		die "echoping cannot use both ssl and gnutls at once"
	fi
}

src_compile() {
	econf \
		--config-cache \
		--disable-ttcp \
		$(use_with gnutls) \
		$(use_enable http)  \
		$(use_enable icp) \
		$(use_with idn libidn) \
		$(use_enable smtp) \
		$(use_enable tos) \
		$(use_enable priority) \
		$(use_with ssl) || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	# They are not installed by make install
	dodoc README AUTHORS ChangeLog DETAILS NEWS TODO
}
