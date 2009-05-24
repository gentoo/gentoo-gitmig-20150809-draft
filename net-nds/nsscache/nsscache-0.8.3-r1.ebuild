# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/nsscache/nsscache-0.8.3-r1.ebuild,v 1.2 2009/05/24 23:53:36 robbat2 Exp $

inherit distutils

DESCRIPTION="commandline tool to sync directory services to local cache."
HOMEPAGE="http://code.google.com/p/nsscache/"
SRC_URI="http://nsscache.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nssdb nsscache"

RDEPEND="dev-python/python-ldap
		nssdb? ( sys-libs/nss-db )
		nsscache? ( sys-auth/libnss-cache )"
DEPEND="$RDEPEND"

src_unpack() {
	distutils_src_unpack
	epatch "${FILESDIR}"/${PN}-0.8.3-starttls.patch
}

src_install() {
	distutils_src_install
	insinto /etc
	doins "$FILESDIR/nsscache.conf" # overwrite default with working config.
	doman *.[1-8]
	dodoc THANKS nsscache.cron
	keepdir /var/lib/nsscache
}
