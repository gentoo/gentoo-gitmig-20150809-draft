# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netperf/netperf-2.2.4.ebuild,v 1.10 2004/07/27 00:18:39 mr_bones_ Exp $

inherit flag-o-matic

if [[ $PV == *.*.* ]]; then
	MY_P=${P%.*}pl${PV##*.}	# convert netperf-2.2.4 => netperf-2.2pl4
	S=${WORKDIR}/${MY_P}
else
	MY_P=${P}
fi

DESCRIPTION="Network performance benchmark including tests for TCP, UDP, sockets, ATM and more."
SRC_URI="ftp://ftp.cup.hp.com/dist/networking/benchmarks/netperf/${MY_P}.tar.gz"
HOMEPAGE="http://www.netperf.org/"
LICENSE="netperf"
SLOT="0"
KEYWORDS="x86 sparc ia64 alpha amd64 ppc64 macos"

IUSE="ipv6"

RDEPEND="virtual/libc >=sys-apps/sed-4"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile() {
	use macos || append-flags -DDO_UNIX
	use ipv6 && append-flags -DDO_IPV6
	emake CFLAGS="${CFLAGS}" || die
	sed -i 's:^\(NETHOME=\).*:\1/usr/bin:' *_script
}

src_install () {
	# binaries
	dosbin netserver
	dobin netperf

	# init.d / conf.d
	exeinto /etc/init.d ; newexe ${FILESDIR}/${PN}-2.2-init netperf
	insinto /etc/conf.d ; newins ${FILESDIR}/${PN}-2.2-conf netperf

	# man pages
	newman netserver.man netserver.1
	newman netperf.man netperf.1

	# documentation and example scripts
	dodoc ACKNWLDGMNTS COPYRIGHT README Release_Notes netperf.ps
	mkdir ${D}/usr/share/doc/${PF}/examples
	cp *_script ${D}/usr/share/doc/${PF}/examples
}
