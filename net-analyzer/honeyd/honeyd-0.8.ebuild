# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/honeyd/honeyd-0.8.ebuild,v 1.10 2006/02/15 22:59:06 jokey Exp $

DESCRIPTION="Honeyd is a small daemon that creates virtual hosts on a network"
HOMEPAGE="http://www.citi.umich.edu/u/provos/honeyd/"
SRC_URI="http://www.citi.umich.edu/u/provos/honeyd/${P}.tar.gz
	http://www.tracking-hackers.com/solutions/honeyd/honeyd-0.7a-beta2.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
IUSE="doc"

DEPEND=">=dev-libs/libdnet-1.7
	>=dev-libs/libevent-0.6
	net-libs/libpcap"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:^CFLAGS = -O2:CFLAGS = ${CFLAGS}:g" Makefile.in || die "sed failed"
}

src_compile() {
	econf --with-libdnet=/usr || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodoc README
	dosbin honeyd

	einstall || die "make install failed"

	rm ${D}/usr/bin/honeyd
	rm ${D}/usr/share/honeyd/README

	dodir /usr/share/honeyd/scripts
	exeinto /usr/share/honeyd/scripts
	doexe scripts/web.sh scripts/router-telnet.pl scripts/test.sh

	insinto /etc
	newins config.sample honeyd.conf || die "failed to install honeyd.conf"

	newinitd ${FILESDIR}/${PN}.initd ${PN}
	newconfd ${FILESDIR}/${PN}.confd ${PN}

	# This adds all the services and example configurations collected
	# by Lance Spitzer

	# Install the white-papers if 'doc' USE flags are specified
	use doc && dodoc ${WORKDIR}/honeyd-0.7a-beta2/contrib/*

	# Install the example configurations
	cd ${WORKDIR}/honeyd-0.7a-beta2
	dodoc honeyd.conf nmap.prints nmap.assoc pf.os xprobe2.conf
	dodoc honeyd.conf.simple honeyd.conf.bloat nmap.prints.new
	dodoc xprobe2.conf.new honeyd.conf.networks

	# Install all the example scripts
	cd ${WORKDIR}/honeyd-0.7a-beta2/scripts
	cp -R * ${D}/usr/share/honeyd/scripts/
	cd ${D}/usr/share/honeyd/scripts/
	find -type f -name "*.sh" -o -name "*.pl" | xargs chmod +x
}

