# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netperf/netperf-2.2.ebuild,v 1.9 2003/09/05 23:40:10 msterret Exp $

MY_P=${P}alpha
S=${WORKDIR}/${P}alpha
DESCRIPTION="This is a brief readme file for the netperf TCP/UDP/sockets/etc
performance benchmark tools"
SRC_URI="ftp://ftp.cup.hp.com/dist/networking/benchmarks/netperf/${MY_P}.tar.gz"
HOMEPAGE="http://www.netperf.org/"

DEPEND=""

SLOT="0"
LICENSE="HP"
KEYWORDS="x86 sparc "

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/netperf-2.2alpha.diff
}

src_compile() {

	make || die
}

src_install () {

	exeinto /usr/share/netperf
	doexe netperf netserver tcp_range_script tcp_stream_script \
		tcp_rr_script udp_stream_script udp_rr_script snapshot_script
	dodoc ACKNWLDGMNTS COPYRIGHT README Release_Notes


}
