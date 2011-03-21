# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ippl/ippl-1.4.14-r2.ebuild,v 1.2 2011/03/21 14:49:51 flameeyes Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="A daemon which logs TCP/UDP/ICMP packets"
HOMEPAGE="http://pltplp.net/ippl/"
SRC_URI="http://pltplp.net/ippl/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="|| ( sys-devel/bison >=dev-util/yacc-1.9.1-r1 )
	>=sys-devel/flex-2.5.4a-r4"
RDEPEND=""

pkg_setup() {
	enewuser ippl
}

src_prepare() {
	epatch \
		"${FILESDIR}"/ippl-1.4.14-noportresolve.patch \
		"${FILESDIR}"/ippl-1.4.14-manpage.patch \
		"${FILESDIR}"/ippl-1.4.14-privilege-drop.patch \
		"${FILESDIR}"/ippl-1.4.14-includes.patch
	sed -i Source/Makefile.in \
		-e 's|^LDFLAGS=|&@LDFLAGS@|g' \
		|| die "sed Source/Makefile.in"
	sed -i Makefile.in \
		-e 's|make |$(MAKE) |g' \
		|| die "sed Makefile.in"
	tc-export CC
}

src_compile() {
	# parallel make failure, bug #351287
	emake -j1 || die "emake failed"
}

src_install() {
	dosbin Source/ippl

	insinto "/etc"
	doins ippl.conf

	doman Docs/{ippl.8,ippl.conf.5}

	dodoc BUGS CREDITS HISTORY README TODO

	newinitd "${FILESDIR}"/ippl.rc ippl
}
