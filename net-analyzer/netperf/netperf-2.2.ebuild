# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netperf/netperf-2.2.ebuild,v 1.1 2001/07/15 05:57:35 lamer Exp $
A=netperf-2.2alpha.tar.gz
S=${WORKDIR}/${PN}-2.2alpha
DESCRIPTION="This is a brief readme file for the netperf TCP/UDP/sockets/etc
performance benchmark tools"
SRC_URI="ftp://ftp.cup.hp.com/dist/networking/benchmarks/netperf/${A}"
HOMEPAGE="http://www.netperf.org/"
DEPEND=""

#RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
   patch -p0 < ${FILESDIR}/netperf-2.2alpha.diff
}

src_compile() {
	
	try make
	#try make
}

src_install () {
	
	exeinto /usr/share/netperf
	doexe netperf netserver tcp_range_script tcp_stream_script \
		tcp_rr_script udp_stream_script udp_rr_script snapshot_script
	dodoc ACKNWLDGMNTS COPYRIGHT README Release_Notes
	

}

