# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/honeyd/honeyd-0.5.ebuild,v 1.4 2004/03/21 12:09:10 mboman Exp $

inherit eutils

DESCRIPTION="Honeyd is a small daemon that creates virtual hosts on a network"
HOMEPAGE="http://www.citi.umich.edu/u/provos/honeyd/"
SRC_URI="http://www.citi.umich.edu/u/provos/honeyd/${P}.tar.gz
	http://www.citi.umich.edu/u/provos/honeyd/patches/${PV}/001-ipfrag.patch
	http://www.citi.umich.edu/u/provos/honeyd/patches/${PV}/002-proxy.patch"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

IUSE=""
DEPEND=">=libdnet-1.4
	>=libevent-0.6
	>=libpcap-0.7.1"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/001-ipfrag.patch
	epatch ${DISTDIR}/002-proxy.patch
}

src_compile() {
	econf --with-libdnet=/usr || die "econf failed"
	emake CFLAGS="${CFLAGS} -Wall -g \
		-DPATH_HONEYDDATA=${honeyddatadir} \
		-DPATH_HONEYDLIB=${honeydlibdir} " \
		|| die "emake failed"
}

src_install() {
	dodoc README
	dosbin honeyd

	einstall

	rm ${D}/usr/bin/honeyd
	rm ${D}/usr/share/honeyd/README

	dodir /usr/share/honeyd/scripts
	exeinto /usr/share/honeyd/scripts
	doexe scripts/web.sh scripts/router-telnet.pl scripts/test.sh
}

