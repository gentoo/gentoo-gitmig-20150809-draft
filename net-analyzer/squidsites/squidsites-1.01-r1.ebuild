# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/squidsites/squidsites-1.01-r1.ebuild,v 1.3 2011/12/15 16:08:13 ago Exp $

EAPI="2"

inherit toolchain-funcs

IUSE=""
DESCRIPTION="a tool that parses Squid access log file and generates a report of the most visited sites."
HOMEPAGE="http://www.stefanopassiglia.com/misc.htm"
SRC_URI="http://www.stefanopassiglia.com/downloads/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="amd64 ~ppc x86"

DEPEND=""
RDEPEND=""
S="${WORKDIR}/src"

src_prepare() {
	# Respect CFLAGS
	sed -i Makefile \
		-e '/^CCFLAGS=/s|-g|$(CFLAGS) $(LDFLAGS)|' \
		|| die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install () {
	cd "${WORKDIR}"
	dobin src/squidsites
	dodoc Authors Bugs ChangeLog GNU-Manifesto.html README
}
