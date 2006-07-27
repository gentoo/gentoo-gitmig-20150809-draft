# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/echoping/echoping-5.2.0.ebuild,v 1.6 2006/07/27 02:47:09 vanquirius Exp $

inherit eutils

DESCRIPTION="echoping is a small program to test performances of remote hosts with TCP 'echo' packets"
HOMEPAGE="http://echoping.sourceforge.net/"
SRC_URI="mirror://sourceforge/echoping/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
IUSE="gnutls http icp idn priority smtp ssl tos"

# Add suport to libidn 
DEPEND="gnutls? ( >=net-libs/gnutls-1.0.17 )
	ssl?	( >=dev-libs/openssl-0.9.7d )
	idn?	( net-dns/libidn )"

pkg_setup() {
	# bug 141782 - conflicting USE flags - ssl and gnutls
	if use ssl && use gnutls ; then
		eerror "You cannot emerge net-analyzer/echoping with both"
		eerror "ssl and gnutls USE flags set. Please choose one."
		eerror
		eerror "For example, you can add the line"
		eerror
		eerror "net-analyzer/echoping -gnutls"
		eerror "to your /etc/portage/package.use"
		die "echoping cannot use both ssl and gnutls at once"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	if ! use http ; then
		# This patch defines maxtoread eventhough http is not 
		# enabled. This avoids an error in readline.c:56.
		epatch "${FILESDIR}"/maxtoread-${PV}.patch
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
	make install DESTDIR="${D}" || die

	# They are not installed by make install
	dodoc README AUTHORS ChangeLog DETAILS NEWS TODO
}
