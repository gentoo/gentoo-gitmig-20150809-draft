# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/bozohttpd/bozohttpd-20040218.ebuild,v 1.2 2004/08/14 13:50:40 swegener Exp $

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
	cp ${FILESDIR}/${P}.Makefile Makefile
}

src_install ()
{
	dodir usr/bin
	dodir usr/share/man
	PREFIX="${D}/usr" einstall || die

	insinto /etc/conf.d; newins ${FILESDIR}/${P}.conffile   bozohttpd
	exeinto /etc/init.d; newexe ${FILESDIR}/${P}.initscript bozohttpd
}

pkg_postinst()
{
	einfo "Remember to edit /etc/conf.d/bozohttpd to suit your needs."
}
