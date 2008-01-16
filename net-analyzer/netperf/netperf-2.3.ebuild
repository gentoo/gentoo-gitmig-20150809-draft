# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netperf/netperf-2.3.ebuild,v 1.11 2008/01/16 20:27:16 grobian Exp $

inherit flag-o-matic

if [[ $PV == *.*.* ]]; then
	MY_P=${P%.*}pl${PV##*.}	# convert netperf-2.2.4 => netperf-2.2pl4
	S=${WORKDIR}/${MY_P}
else
	MY_P=${P}
fi

DESCRIPTION="Network performance benchmark including tests for TCP, UDP, sockets, ATM and more."
SRC_URI="ftp://ftp.netperf.org/netperf/archive/${MY_P}.tar.gz"
HOMEPAGE="http://www.netperf.org/"
LICENSE="netperf"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ppc64 sparc x86"

IUSE="ipv6"

DEPEND="virtual/libc >=sys-apps/sed-4"

src_compile() {
	append-flags -DDO_UNIX
	use ipv6 && append-flags -DDO_IPV6
	emake CFLAGS="${CFLAGS}" || die
	sed -i 's:^\(NETHOME=\).*:\1/usr/bin:' *_script
}

src_install () {
	# binaries
	dosbin netserver
	dobin netperf

	# init.d / conf.d
	newinitd ${FILESDIR}/${PN}-2.2-init netperf
	newconfd ${FILESDIR}/${PN}-2.2-conf netperf

	# man pages
	newman netserver.man netserver.1
	newman netperf.man netperf.1

	# documentation and example scripts
	dodoc ACKNWLDGMNTS COPYRIGHT README Release_Notes netperf.ps
	dodir /usr/share/doc/${PF}/examples
	cp *_script ${D}/usr/share/doc/${PF}/examples
}
