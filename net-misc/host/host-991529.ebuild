# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/host/host-991529.ebuild,v 1.15 2003/06/28 22:17:36 taviso Exp $

S="${WORKDIR}"

DESCRIPTION="the standalone host tool, supports LOC reporting (RFC1876)"
#this is somewhat old tool, has not been changed since 1999,
#still looks like host from bind does not provide all possible functionality
#at least xtraceroute wants LOC support, which is provided by this tool

SRC_URI="ftp://ftp.ripe.net/tools/dns/${PN}.tar.Z"
HOMEPAGE="http://www.dtek.chalmers.se/~d3august/xt/"
#that's the homepage for xtraceroute, not host, but that's best I can do
#at least it is mentioned there

DEPEND="net-dns/bind-tools"
#either bind or bind-tools will do,
#but since bind-tools is just a partiall install of bind
#there is no point in introducing new use var and doing PROVIDE dance..


SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha mips hppa"

src_unpack() {
	cd ${S}
	unpack "${PN}.tar.Z"

	mv Makefile Makefile-orig
	sed -e "s:staff:root:" Makefile-orig > Makefile
}

src_compile() {
	emake CC="${CC}" CXX="${CXX}" || die
}

src_install () {
	#ATTN!
	#This util has slightly different format of output from "standard" host
	#I will rename it to hostx, I hope this does not conflict with anything big
	cd ${WORKDIR}
	mv host hostx
	mv host.1 hostx.1
	dobin hostx
	doman hostx.1
	dodoc RE* 
}
