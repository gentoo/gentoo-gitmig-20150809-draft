# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/echoping/echoping-5.2.0.ebuild,v 1.3 2005/04/05 22:57:13 angusyoung Exp $

inherit eutils

DESCRIPTION="echoping is a small program to test performances of remote hosts with TCP 'echo' packets"
HOMEPAGE="http://echoping.sourceforge.net/"
SRC_URI="mirror://sourceforge/echoping/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="gnutls http icp idn priority smtp ssl tos"

# Add suport to libidn 
DEPEND="gnutls? ( >=net-libs/gnutls-1.0.17 )
	ssl?	( >=dev-libs/openssl-0.9.7d )
	idn?	( net-dns/libidn )"

src_unpack() {
	unpack ${A}
	cd ${S}

	if ! use http ; then
		# This patch defines maxtoread eventhough http is not 
		# enabled. This avoids an error in readline.c:56.
		epatch ${FILESDIR}/maxtoread-${PV}.patch
	fi
}

src_compile() {
	econf \
		--disable-ttcp \
		`use_with gnutls` \
		`use_enable http`  \
		`use_enable icp` \
		`use_with idn libidn` \
		`use_enable smtp` \
		`use_enable tos` \
		`use_enable priority` \
		`use_with ssl` || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR=${D} || die

	# They are not installed by emake install
	dodoc README AUTHORS ChangeLog COPYING DETAILS NEWS TODO
}
