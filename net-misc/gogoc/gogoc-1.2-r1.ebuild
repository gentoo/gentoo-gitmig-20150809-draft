# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gogoc/gogoc-1.2-r1.ebuild,v 1.5 2010/10/20 10:08:02 fauli Exp $

EAPI=2

inherit eutils versionator toolchain-funcs

MY_P=${PN}-$(replace_all_version_separators "_")
if [[ ${MY_P/_beta/} != ${MY_P} ]]; then
	MY_P=${MY_P/_beta/-BETA}
else
	MY_P=${MY_P}-RELEASE
fi

DESCRIPTION="Client to connect to a tunnel broker using the TSP protocol (freenet6 for example)"
HOMEPAGE="http://gogonet.gogo6.com/page/download-1"
SRC_URI="http://gogo6.com/downloads/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="debug"

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}
	sys-apps/iproute2"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-overflow.patch

	# Make the makefile handle linking correctly
	find . -name Makefile -exec sed -i \
		-e 's:LDFLAGS:LDLIBS:g' \
		-e '/\$(LDLIBS)/s:-o:$(LDFLAGS) -o:' \
		{} + || die "multised failed"

	sed -i -e 's:/usr/local/etc/gogoc:/etc/gogoc:' \
		gogoc-tsp/platform/*/tsp_local.c \
		|| die "sed failed"
}

src_configure() { :; }

src_compile() {
	# parallel make fails as inter-directory dependecies are missing.
	emake -j1 \
		AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)" \
		CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getCXX)" \
		EXTRA_CFLAGS="${CFLAGS}" EXTRA_CXXFLAGS="${CXXFLAGS}" \
		$(use debug && echo DEBUG=1) \
		all target=linux || die "Build Failed"

	emake -C gogoc-tsp/conf \
		PLATFORM=linux PLATFORM_DIR=../platform BIN_DIR=../bin \
		gogoc.conf.sample || die
}

src_install() {
	dodoc README || die

	cd "${S}"/gogoc-tsp
	dosbin bin/gogoc || die

	dodoc bin/gogoc.conf.sample || die

	exeinto /etc/gogoc/template
	doexe template/linux.sh || die

	newinitd "${FILESDIR}"/gogoc.rc gogoc || die

	doman man/{man5/gogoc.conf.5,man8/gogoc.8} || die
	keepdir /var/lib/gogoc || die

	diropts -m0700
	keepdir /etc/gogoc || die
}

pkg_postinst() {
	elog "You should create an /etc/gogoc/gogoc.conf file starting from"
	elog "the sample configuration in /usr/share/doc/${PF}/gogo.conf.sample.*"
	elog ""
	elog "To add support for a TSP IPv6 connection at startup,"
	elog "remember to run:"
	elog "# rc-update add gogoc default"
}
