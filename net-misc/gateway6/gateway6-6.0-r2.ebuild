# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gateway6/gateway6-6.0-r2.ebuild,v 1.5 2010/10/24 17:59:21 armin76 Exp $

EAPI=2

inherit eutils versionator toolchain-funcs

MY_P=gw6c-$(replace_all_version_separators "_")
MY_P=${MY_P/_beta/-BETA}

DESCRIPTION="Client to connect to a tunnel broker using the TSP protocol (freenet6 for example)"
HOMEPAGE="http://go6.net/4105/application.asp"
SRC_URI="http://go6.net/4105/file.asp?file_id=158&file=/${MY_P}.tar.gz"

LICENSE="VPL-1.0"
SLOT="0"
KEYWORDS="amd64 hppa sparc x86"
IUSE="debug"

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}
	sys-apps/iproute2"

S="${WORKDIR}/${MY_P}-RELEASE"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-6.0_beta4-no-template-validation.patch
	epatch "${FILESDIR}"/${P}-overflow.patch

	# Make the makefile handle linking correctly
	find . -name Makefile -exec sed -i \
		-e 's:LDFLAGS:LDLIBS:g' \
		-e '/\$(LDLIBS)/s:-o:$(LDFLAGS) -o:' \
		{} + || die "multised failed"
}

src_configure() { :; }

src_compile() {
	# parallel make fails as inter-directory dependecies are missing.
	emake -j1 \
		AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)" \
		CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getCXX)" \
		EXTRA_CFLAGS="${CFLAGS}" EXTRA_CXXFLAGS="${CXXFLAGS}" \
		$(use debug && echo DEBUG=1) \
		all configdir=/etc/gateway6 target=linux || die "Build Failed"
}

src_install() {
	cd "${S}"/tspc-advanced
	dosbin bin/gw6c || die

	insopts -m 600
	insinto /etc/gateway6
	doins "${FILESDIR}"/gw6c.conf || die
	exeinto /etc/gateway6/template
	doexe template/linux.sh || die

	newinitd "${FILESDIR}"/gw6c.rc2 gw6c || die

	doman man/{man5/gw6c.conf.5,man8/gw6c.8} || die
	keepdir /var/lib/gateway6 || die

	insinto /usr/share/doc/${PF}
	doins "${S}"/*.pdf || die
}

pkg_postinst() {
	elog "To add support for a TSP IPv6 connection at startup,"
	elog "remember to run:"
	elog "# rc-update add gw6c default"
	elog ""
	elog "NOTE: authenticated connection to broker.freenet6.net seems to"
	elog "not work with gateway6 anymore, it only seems to work with"
	elog "anonymous usage."
}
