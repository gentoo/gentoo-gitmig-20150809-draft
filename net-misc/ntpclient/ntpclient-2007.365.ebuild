# Copyright 2008-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ntpclient/ntpclient-2007.365.ebuild,v 1.1 2008/06/22 06:36:02 solar Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A NTP (RFC-1305) client for unix-alike computers."
HOMEPAGE="http://doolittle.icarus.com/~larry/"
SRC_URI="http://doolittle.icarus.com/${PN}/${PN}_${PV/./_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

S="${WORKDIR}/${PN}-2007"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e s/'-O2'// Makefile
}

src_compile() {
	filter-ldflags -Wl,--as-needed
	tc-export CC
	emake || die "emake failed in src_compile"
}

src_install() {
	dodir /usr/bin
	dobin ntpclient
}
