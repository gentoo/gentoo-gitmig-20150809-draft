# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/honeyd/honeyd-1.0.ebuild,v 1.5 2006/02/15 22:59:06 jokey Exp $

inherit eutils

DESCRIPTION="Honeyd is a small daemon that creates virtual hosts on a network"
HOMEPAGE="http://www.citi.umich.edu/u/provos/honeyd/"
SRC_URI="http://www.citi.umich.edu/u/provos/honeyd/${P}.tar.gz
	http://www.tracking-hackers.com/solutions/honeyd/honeyd-0.7a-beta2.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
IUSE="doc"

DEPEND=">=dev-libs/libdnet-1.7
	>=dev-libs/libevent-1.0
	net-libs/libpcap"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:^CFLAGS = -O2:CFLAGS = ${CFLAGS}:g" Makefile.in || die "sed failed"
	epatch ${FILESDIR}/${P}-gcc4.diff
}

src_compile() {
	econf --with-libdnet=/usr || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodoc README TODO
	dosbin honeyd || die "dosbin failed"

	einstall || die "make install failed"

	rm ${D}/usr/bin/honeyd
	rm ${D}/usr/share/honeyd/README

	insinto /etc
	newins config.sample honeyd.conf || die "failed to install honeyd.conf"

	newinitd ${FILESDIR}/${PN}.initd ${PN} || die
	newconfd ${FILESDIR}/${PN}.confd ${PN} || die

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
	cp -R scripts ${D}/usr/share/honeyd/
	find ${D}/usr/share/honeyd/scripts \
		-type f -name '*.sh' -o -name '*.pl' -exec chmod +x {} \;
}

