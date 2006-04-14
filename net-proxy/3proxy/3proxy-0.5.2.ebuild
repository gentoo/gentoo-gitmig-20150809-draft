# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/3proxy/3proxy-0.5.2.ebuild,v 1.2 2006/04/14 07:34:59 mrness Exp $

inherit toolchain-funcs

DESCRIPTION="really tiny cross-platform proxy servers set"
HOMEPAGE="http://www.security.nnov.ru/soft/3proxy/"
SRC_URI="mirror://gentoo/${P}.tgz"
#http://www.security.nnov.ru/soft/3proxy/${PV}/3proxy.tgz

LICENSE="3proxy"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^CFLAGS/s:-g -O2:${CFLAGS}:" \
		-e "/^LDFLAGS/s:-O2:${LDFLAGS}:" \
		Makefile.unix || die "sed Makefile"
	sed -i 's:/usr/local::' src/stringtable.c || die "sed stringtable"
	find . -type f -print0 | xargs -0 chmod a-x
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		LN="$(tc-getCC)" \
		-f Makefile.unix \
		|| die
}

src_install() {
	local x

	cd "${S}"/src
	dobin 3proxy || die "dobin 3proxy failed"
	for x in proxy socks pop3p tcppm udppm mycrypt dighosts ; do
		newbin ${x} ${PN}-${x} || die "newbin ${x} failed"
		[[ -f ${S}/man/${x}.8 ]] \
			&& newman "${S}"/man/${x}.8 ${PN}-${x}.8
	done

	dodoc $(find "${S}"/cfg -type f)
	doman "${S}"/man/3proxy*.[38]

	cd "${S}"
	dodoc Changelog Readme Release.notes
	dodoc $(find "${S}"/doc -name '*.txt')
	dohtml $(find "${S}"/doc -name '*.html')
}
