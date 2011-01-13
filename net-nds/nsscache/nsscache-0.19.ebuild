# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/nsscache/nsscache-0.19.ebuild,v 1.1 2011/01/13 07:29:01 robbat2 Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils python distutils

DESCRIPTION="commandline tool to sync directory services to local cache"
HOMEPAGE="http://code.google.com/p/nsscache/"
SRC_URI="http://nsscache.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nssdb nsscache"

DEPEND="dev-python/python-ldap
		dev-python/pycurl"
RDEPEND="${DEPEND}
		nssdb? ( sys-libs/nss-db )
		nsscache? ( >=sys-auth/libnss-cache-0.10 )"
RESTRICT="test"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}"/${PN}-0.8.3-starttls.patch
}

src_install() {
	distutils_src_install
	rm "${ED}"/usr/bin/runtests*
	insinto /etc
	doins "${FILESDIR}/nsscache.conf" # overwrite default with working config.
	doman nsscache.1 nsscache.conf.5
	dodoc THANKS nsscache.cron
	keepdir /var/lib/nsscache
}

#src_test() {
	# Needs several modules not in the tree
	#./runtests.py || die
#}
