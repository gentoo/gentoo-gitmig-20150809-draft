# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/3proxy/3proxy-0.5b.ebuild,v 1.2 2005/05/15 16:00:03 voxus Exp $

inherit toolchain-funcs

DESCRIPTION="really tiny cross-platform proxy servers set"
HOMEPAGE="http://www.security.nnov.ru/soft/3proxy/"
SRC_URI="http://www.security.nnov.ru/soft/3proxy/${PV}/3proxy.tgz"

LICENSE="3proxy"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/^CFLAGS/s:-O2:${CFLAGS}:" \
		Makefile.unix || die "sed Makefile"
	sed -i 's:/usr/local::' src/stringtable.c || die "sed stringtable"
	find . -type f -print0 | xargs -0 chmod a-x
}

src_compile() {
	emake CC="$(tc-getCC)" LN="$(tc-getCC)" -f Makefile.unix || die
}

src_install() {
	cd ${S}/src
	dobin 3proxy || die "dobin 3proxy failed"
	for bin in proxy socks pop3p tcppm udppm mycrypt dighosts ; do
		newbin ${bin} ${PN}-${bin} || die "newbin ${bin} failed"
	done

	cd ${S}/cfg
	find -type f | dodoc

	cd ${S}/man
	doman *.[38]

	cd ${S}
	dodoc Changelog Readme Release.notes
	cd ${S}/doc
	find -name '*.txt' | dodoc
	find -name '*.html' | dohtml
}
