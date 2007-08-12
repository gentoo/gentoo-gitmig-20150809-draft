# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/honeyd/honeyd-1.5c.ebuild,v 1.1 2007/08/12 20:29:54 pva Exp $

DESCRIPTION="Honeyd is a small daemon that creates virtual hosts on a network"
HOMEPAGE="http://www.honeyd.org/"
SRC_URI="http://www.citi.umich.edu/u/provos/honeyd/${P}.tar.gz
	http://www.tracking-hackers.com/solutions/honeyd/honeyd-0.7a-beta2.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND="net-libs/libpcap
	dev-libs/libdnet
	>=dev-libs/libevent-1.0
	dev-libs/libdnsres
	dev-libs/libpcre
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "s:^CFLAGS = -O2:CFLAGS = ${CFLAGS}:g" Makefile.in || die "sed failed"
}

src_compile() {
	econf --with-libdnet=/usr || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc README TODO
	rm "${D}"/usr/share/honeyd/README

	insinto /etc
	newins config.sample honeyd.conf || die "failed to install honeyd.conf"

	newinitd "${FILESDIR}"/${PN}.initd ${PN} || die
	newconfd "${FILESDIR}"/${PN}.confd ${PN} || die

	rm "${D}"/usr/bin/honeyd
	dosbin honeyd || die "dosbin failed"

	# This adds all the services and example configurations collected
	# by Lance Spitzer

	# Install the white-papers if 'doc' USE flags are specified
	use doc && dodoc "${WORKDIR}"/honeyd-0.7a-beta2/contrib/*

	cp -R scripts "${D}"/usr/share/honeyd/

	# Install the example configurations
	cd "${WORKDIR}"/honeyd-0.7a-beta2
	dodoc honeyd.conf nmap.prints nmap.assoc pf.os xprobe2.conf
	dodoc honeyd.conf.simple honeyd.conf.bloat nmap.prints.new
	dodoc xprobe2.conf.new honeyd.conf.networks

	# Install all the example scripts
	cp -R scripts "${D}"/usr/share/honeyd/
	find "${D}"/usr/share/honeyd/scripts \
		-type f -name '*.sh' -o -name '*.pl' -exec chmod +x {} \;
}
