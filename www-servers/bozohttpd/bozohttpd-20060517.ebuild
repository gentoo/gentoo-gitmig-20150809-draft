# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/bozohttpd/bozohttpd-20060517.ebuild,v 1.1 2007/04/19 09:33:11 s4t4n Exp $

inherit eutils

DESCRIPTION="bozohttpd is a small and secure http server"
HOMEPAGE="http://www.eterna.com.au/bozohttpd/"
SRC_URI="http://www.eterna.com.au/bozohttpd/${P}.tar.bz2"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
DEPEND=">=dev-libs/openssl-0.9.8d
	>=sys-apps/sed-4.1.5"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# Rename Makefile
	mv Makefile.boot Makefile

	# Make it honour Gentoo CFLAGS
	sed -ie "s/-O/${CFLAGS}/" Makefile
}

src_install ()
{
	dobin bozohttpd
	doman bozohttpd.8

	insinto /etc/conf.d; newins ${FILESDIR}/${PN}.conffile   bozohttpd
	exeinto /etc/init.d; newexe ${FILESDIR}/${PN}.initscript bozohttpd
}

pkg_postinst()
{
	einfo "Remember to edit /etc/conf.d/bozohttpd to suit your needs."
}
