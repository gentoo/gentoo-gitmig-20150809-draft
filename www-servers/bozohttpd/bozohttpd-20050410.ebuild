# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/bozohttpd/bozohttpd-20050410.ebuild,v 1.4 2007/10/28 14:09:40 phreak Exp $

inherit eutils

DESCRIPTION="bozohttpd is a small and secure http server"
HOMEPAGE="http://www.eterna.com.au/bozohttpd/"
SRC_URI="http://www.eterna.com.au/bozohttpd/${P}.tar.bz2"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
DEPEND=">=dev-libs/openssl-0.9.7d-r1"
RDEPEND="${DEPEND}
	virtual/logger"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# Rename Makefile
	mv Makefile.boot Makefile
}

src_install ()
{
	dobin bozohttpd
	doman bozohttpd.8

	newconfd ${FILESDIR}/${PN}.conffile   bozohttpd
	newinitd ${FILESDIR}/${PN}.initscript bozohttpd
}

pkg_postinst()
{
	einfo "Remember to edit /etc/conf.d/bozohttpd to suit your needs."
}
