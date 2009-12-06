# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nstx/nstx-1.1_beta6-r3.ebuild,v 1.1 2009/12/06 19:37:39 robbat2 Exp $

inherit versionator toolchain-funcs eutils linux-info

MY_PV=$(replace_version_separator 2 - "${PV}")
MY_P="${PN}-${MY_PV}"
DEBIAN_PV="5"
DEBIAN_A="${PN}_${MY_PV}-${DEBIAN_PV}.diff.gz"

DESCRIPTION="IP over DNS tunnel"
SRC_URI="http://dereference.de/nstx/${MY_P}.tgz
		mirror://debian/pool/main/${PN:0:1}/${PN}/${DEBIAN_A}"
HOMEPAGE="http://dereference.de/nstx/"
RDEPEND="virtual/libc"
DEPEND="virtual/os-headers
		${RDEPEND}"
KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
S="${WORKDIR}/${MY_P}"

CONFIG_CHECK="~TUN"

src_unpack() {
	unpack "${MY_P}.tgz"
	epatch "${DISTDIR}"/${DEBIAN_A}
	epatch "${FILESDIR}"/${PN}-1.1_beta6_00-linux-tuntap.patch
	epatch "${FILESDIR}"/${PN}-1.1_beta6_01-bind-interface-name.patch
	epatch "${FILESDIR}"/${PN}-1.1_beta6_02-warn-on-frag.patch
	epatch "${FILESDIR}"/${PN}-1.1_beta6_03-delete-dwrite.patch
	epatch "${FILESDIR}"/${PN}-1.1_beta6_04-delete-werror.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	into /usr
	dosbin nstxcd nstxd
	dodoc README Changelog
	doman *.8

	newinitd "${FILESDIR}"/nstxd.init nstxd
	newconfd "${FILESDIR}"/nstxd.conf nstxd
	newinitd "${FILESDIR}"/nstxcd.init nstxcd
	newconfd "${FILESDIR}"/nstxcd.conf nstxcd
}

pkg_postinst() {
	einfo "Please read the documentation provided in"
	einfo "  `find /usr/share/doc/${PF}/ -name 'README*'`"
}
