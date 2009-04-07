# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/freenet6/freenet6-6.0.ebuild,v 1.2 2009/04/07 06:57:13 voyageur Exp $

inherit eutils versionator toolchain-funcs

MY_P=gw6c-$(replace_all_version_separators "_")
MY_P=${MY_P/_beta/-BETA}

DESCRIPTION="Client to configure an IPv6 tunnel to freenet6"
HOMEPAGE="http://www.freenet6.net"
SRC_URI="http://go6.net/4105/file.asp?file_id=158&file=/${MY_P}.tar.gz"

LICENSE="VPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE="radvd"

DEPEND="dev-libs/openssl
	sys-apps/iproute2
	radvd? ( net-misc/radvd )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-RELEASE"

src_unpack() {
	unpack ${A}
	cd "${S}"

	#epatch "${FILESDIR}"/${PN}-5.1-gcc43.patch
	epatch "${FILESDIR}"/${PN}-6.0_beta4-no-template-validation.patch

	for i in gw6c-config gw6c-messaging ; do
		sed -i -e "s/-O2//" \
			-e "s/CXXFLAGS=/CXXFLAGS+=/" \
			-e "s/CFLAGS=/CFLAGS+=/" \
			-e "s/LDFAGS=/LDFLAGS+=/" \
			${i}/Makefile || die "sed failed in ${i}"
	done

	cd tspc-advanced
	for i in platform/linux platform/unix-common src/lib src/net src/tsp src/xml ; do
		sed -i -e "s/-O2//" \
			-e "s/CXXFLAGS=/CXXFLAGS+=/" \
			-e "s/CFLAGS=/CFLAGS+=/" \
			-e "s/LDFAGS=/LDFLAGS+=/" \
			${i}/Makefile || die "sed failed in ${i}"
	done
}

src_compile() {
	# Parallel compilation broken
	emake -j1\
		AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)" \
		CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		all configdir=/etc/freenet6 target=linux || die "Build Failed"
}

src_install() {
	cd "${S}"/tspc-advanced
	dosbin bin/gw6c

	insopts -m 600
	insinto /etc/freenet6
	doins "${FILESDIR}"/gw6c.conf
	exeinto /etc/freenet6/template
	doexe template/linux.sh

	newinitd "${FILESDIR}"/gw6c.rc gw6c

	doman man/{man5/gw6c.conf.5,man8/gw6c.8}
	dodir /var/lib/freenet6

	dodoc "${S}"/*.pdf
}

pkg_preinst() {
	has_version "=${CATEGORY}/${PN}-1*"
	upgrade_from_1_x=$?
}

pkg_postinst() {
	if [[ $upgrade_from_1_x = 0 ]] ; then
		ewarn "Warning: you are upgrading from an older version"
		ewarn "The configuration file has been renamed to gw6c.conf"
		ewarn "Remember to port your personal settings from tspc.conf to it"
		ewarn "The init script has been renamed to 'gw6c',"
	else
		elog "The freenet6 ebuild installs an init script named 'gw6c'"
	fi
	elog "to coincide with the name of the client binary installed"
	elog "To add support for a freenet6 connection at startup, do"
	elog ""
	elog "# rc-update add gw6c default"
}
