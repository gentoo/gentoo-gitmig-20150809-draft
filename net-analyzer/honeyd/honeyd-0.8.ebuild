# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/honeyd/honeyd-0.8.ebuild,v 1.1 2004/01/21 18:21:43 mboman Exp $

inherit eutils

DESCRIPTION="Honeyd is a small daemon that creates virtual hosts on a network"
HOMEPAGE="http://www.citi.umich.edu/u/provos/honeyd/"
SRC_URI="http://www.citi.umich.edu/u/provos/honeyd/${P}.tar.gz
	http://www.tracking-hackers.com/solutions/honeyd/honeyd-0.7a-beta2.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="doc"
DEPEND=">=dev-libs/libdnet-1.7
	>=dev-libs/libevent-0.6
	>=net-libs/libpcap-0.7.1"
RDEPEND=${DEPEND}

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A} ; cd ${S}

	sed -i "s:^CFLAGS = -O2:CFLAGS = ${CFLAGS}:g" Makefile.in
}

src_compile() {
	econf --with-libdnet=/usr || die "econf failed"
	emake || die
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

	# This adds all the services and example configurations collected
	# by Lance Spitzer

	# Install the white-papers if 'doc' USE flags are specified
	use doc && (
		cd ${WORKDIR}/honeyd-0.7a-beta2/contrib
		dodoc *
	)

	# Install the example configurations
	cd ${WORKDIR}/honeyd-0.7a-beta2
	dodoc honeyd.conf nmap.prints nmap.assoc pf.os xprobe2.conf
	dodoc honeyd.conf.simple honeyd.conf.bloat nmap.prints.new
	dodoc xprobe2.conf.new honeyd.conf.networks

	# Install example start/stop scripts.. Those should _really_
	# be re-written to gentoo instead..
	dodoc start-arpd.sh start-honeyd.sh

	# Install all the example scripts
	cd ${WORKDIR}/honeyd-0.7a-beta2/scripts
	cp -R * ${D}/usr/share/honeyd/scripts/
	cd ${D}/usr/share/honeyd/scripts/
	find -type f -name "*.sh" -o -name "*.pl" | xargs chmod +x


}

