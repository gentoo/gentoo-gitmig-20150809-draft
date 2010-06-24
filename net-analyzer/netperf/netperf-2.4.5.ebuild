# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netperf/netperf-2.4.5.ebuild,v 1.2 2010/06/24 16:00:42 jer Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Network performance benchmark including tests for TCP, UDP, sockets, ATM and more."
SRC_URI="ftp://ftp.netperf.org/netperf/${P}.tar.gz"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

HOMEPAGE="http://www.netperf.org/"
LICENSE="netperf"
SLOT="0"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND="!sci-mathematics/snns"

src_prepare() {
	sed -i 's:^\(#define DEBUG_LOG_FILE "\)/tmp/netperf.debug:\1/var/log/netperf.debug:' src/netserver.c
	epatch "${FILESDIR}"/${PN}-fix-scripts.patch

	# Fixing paths in scripts
	sed -i -e 's:^\(NETHOME=\).*:\1"/usr/bin":' \
			doc/examples/sctp_stream_script \
			doc/examples/tcp_range_script \
			doc/examples/tcp_rr_script \
			doc/examples/tcp_stream_script \
			doc/examples/udp_rr_script \
			doc/examples/udp_stream_script
}

src_install () {
	einstall || die

	# move netserver into sbin as we had it before 2.4 was released with its
	# autoconf goodness
	dodir /usr/sbin
	mv "${D}"/usr/{bin,sbin}/netserver || die

	# init.d / conf.d
	newinitd "${FILESDIR}"/${PN}-2.2-init netperf
	newconfd "${FILESDIR}"/${PN}-2.2-conf netperf

	# documentation and example scripts
	dodoc AUTHORS ChangeLog NEWS README Release_Notes
	dodir /usr/share/doc/${PF}/examples
	#Scripts no longer get installed by einstall
	cp doc/examples/*_script "${D}"/usr/share/doc/${PF}/examples
}
