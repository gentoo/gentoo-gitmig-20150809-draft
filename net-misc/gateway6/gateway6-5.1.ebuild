# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gateway6/gateway6-5.1.ebuild,v 1.1 2009/06/03 15:06:34 voyageur Exp $

inherit eutils versionator toolchain-funcs

MY_PV=$(replace_all_version_separators "_")
DESCRIPTION="Client to connect to a tunnel broker using the TSP protocol (freenet6 for example)"
HOMEPAGE="http://go6.net/4105/application.asp"
SRC_URI="mirror://gentoo/gw6c-${MY_PV}-RELEASE-src.tar.gz"

LICENSE="VPL-1.0"
SLOT="0"
KEYWORDS="amd64 hppa sparc x86"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/tspc-advanced"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"

	epatch "${FILESDIR}"/${P}-gcc43.patch

	for i in gw6c-config gw6c-messaging ; do
		sed -i -e "/ARCHIVER=/s:ar:$(tc-getAR):" \
			-e "/COMPILER=/s:g++:$(tc-getCXX):" \
			-e "/C_COMPILER=/s:gcc:$(tc-getCC):" \
			-e "/CPP_FLAGS=/s:-I.:${CXXFLAGS} -I.:" \
			-e "/C_FLAGS=/s:-I.:${CFLAGS} -I.:" \
			-e "/C_LINKER=/s:gcc:$(tc-getCC):" \
			-e "/LD_FLAGS=/s:-O2::" \
			-e "/LD_FLAGS=/s:-L:${LDFLAGS} -L:" \
			-e "/LINKER=/s:g++:$(tc-getCXX):" \
			-e "/RANLIB=/s:ranlib:$(tc-getRANLIB):" \
			${i}/Makefile || die "sed failed in ${i}"
	done

	cd "${S}"
	for i in platform/linux platform/unix-common src/lib src/net src/tsp src/xml ; do
		sed -i -e "/CC=/s:gcc:$(tc-getCC):" \
			-e "/CFLAGS=/s:-O2:${CFLAGS}:" \
			-e "/LDFLAGS=/s:-L..:${LDFLAGS} -L..:" \
			${i}/Makefile || die "sed failed in ${i}"
	done
}

src_compile() {
	emake all configdir=/etc/gateway6 target=linux || die "Build Failed"
	sed -i "s#tsp-#/tmp/tsp-#" bin/gw6c.conf.sample
}

src_install() {
	dosbin bin/gw6c

	insopts -m 600
	insinto /etc/gateway6
	newins bin/gw6c.conf.sample gw6c.conf
	exeinto /etc/gateway6/template
	doexe template/linux.sh

	newinitd "${FILESDIR}"/gw6c.rc gw6c

	doman man/{man5/gw6c.conf.5,man8/gw6c.8}
}

pkg_postinst() {
	elog "To add support for a TSP IPv6 connection at startup,"
	elog "remember to run:"
	elog "# rc-update add gw6c default"
}
