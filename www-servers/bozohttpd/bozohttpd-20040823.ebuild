# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/bozohttpd/bozohttpd-20040823.ebuild,v 1.1 2004/08/27 12:05:47 s4t4n Exp $

inherit eutils

DESCRIPTION="bozohttpd is a small and secure http server"
HOMEPAGE="http://www.eterna.com.au/bozohttpd/"
SRC_URI="http://www.eterna.com.au/bozohttpd/${P}.tar.bz2"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
DEPEND=">=dev-libs/openssl-0.9.7d-r1"

src_unpack()
{
	unpack ${A}

	# We substitute the Makefile because the original works only with BSD make
	cd ${S}
	rm -f Makefile
	cp ${FILESDIR}/${PN}.Makefile Makefile

	# Apparently, support for '-a' cmd line arg was removed, but left in
	# 'bozohpptd -h' explanations
	epatch ${FILESDIR}/${P}.patch
}

src_install ()
{
	dodir usr/bin
	dodir usr/share/man
	PREFIX="${D}/usr" einstall || die

	insinto /etc/conf.d; newins ${FILESDIR}/${PN}.conffile   bozohttpd
	exeinto /etc/init.d; newexe ${FILESDIR}/${PN}.initscript bozohttpd
}

pkg_postinst()
{
	einfo "Remember to edit /etc/conf.d/bozohttpd to suit your needs."
}
