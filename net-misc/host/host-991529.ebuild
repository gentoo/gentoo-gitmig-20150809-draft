# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/host/host-991529.ebuild,v 1.19 2003/12/24 15:57:13 zul Exp $

S="${WORKDIR}"

# This is somewhat old tool, has not been changed since 1999,
# Still looks like host from bind does not provide all possible functionality
# at least xtraceroute wants LOC support, which is provided by this tool.
DESCRIPTION="the standalone host tool, supports LOC reporting (RFC1876)"
# This is the homepage for xtraceroute, not host, but that's best I can do -
# at least it is mentioned there.
HOMEPAGE="http://www.dtek.chalmers.se/~d3august/xt/"
SRC_URI="ftp://ftp.ripe.net/tools/dns/${PN}.tar.Z"

KEYWORDS="x86 ppc sparc alpha mips hppa -amd64"
LICENSE="as-is"
SLOT="0"

DEPEND=">=sys-apps/sed-4"

src_unpack() {
	cd ${S}
	unpack ${A}

	sed -i -e "s:staff:root:" Makefile || \
		die "sed Makefile failed"
}

src_compile() {
	emake CC="${CC}" COPTS="${CFLAGS}" || \
		die "emake failed"
	# ATTN!
	# This util has slightly different format of output from "standard" host
	# rename it to hostx, hopefully this does not conflict with anything.
	mv host hostx
	mv host.1 hostx.1
}

src_install () {
	cd ${WORKDIR}
	dobin hostx   || die "dobin failed"
	doman hostx.1 || die "doman failed"
	dodoc RE*     || die "dodoc failed"
}
