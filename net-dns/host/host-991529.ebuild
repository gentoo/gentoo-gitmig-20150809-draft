# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/host/host-991529.ebuild,v 1.3 2011/02/06 08:09:22 leio Exp $

# This is somewhat old tool, has not been changed since 1999,
# Still looks like host from bind does not provide all possible functionality
# at least xtraceroute wants LOC support, which is provided by this tool.

# This is the homepage for xtraceroute, not host, but that's the best I can do -
# at least it is mentioned there.

inherit toolchain-funcs

DESCRIPTION="the standalone host tool, supports LOC reporting (RFC1876)"
HOMEPAGE="http://www.dtek.chalmers.se/~d3august/xt/"
SRC_URI="ftp://ftp.ripe.net/tools/dns/${PN}.tar.Z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc ppc64 sparc x86"
IUSE=""

RESTRICT="test"

DEPEND=">=sys-apps/sed-4"

S="${WORKDIR}"

src_unpack() {
	cd ${S}
	unpack ${A}

	sed -i -e "s:staff:root:" Makefile \
		|| die "sed Makefile failed"
}

src_compile() {
	emake CC="$(tc-getCC)" COPTS="${CFLAGS}" \
		|| die "emake failed"
	# ATTN!
	# This util has slightly different format of output from "standard" host
	# rename it to hostx, hopefully this does not conflict with anything.
	mv host hostx
	mv host.1 hostx.1
}

src_install () {
	cd ${WORKDIR}
	dobin hostx || die "dobin failed"
	doman hostx.1
	dodoc RE*
}
