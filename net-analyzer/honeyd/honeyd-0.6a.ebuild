# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/honeyd/honeyd-0.6a.ebuild,v 1.1 2003/08/25 09:42:37 aliz Exp $

inherit eutils

DESCRIPTION="Honeyd is a small daemon that creates virtual hosts on a network"
HOMEPAGE="http://www.citi.umich.edu/u/provos/honeyd/"
SRC_URI="http://www.citi.umich.edu/u/provos/honeyd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=">=net-libs/libdnet-1.4
	>=net-libslibevent-0.6
	>=net-libs/libpcap-0.7.1"
RDEPEND=${DEPEND}

S="${WORKDIR}/${P}"

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

