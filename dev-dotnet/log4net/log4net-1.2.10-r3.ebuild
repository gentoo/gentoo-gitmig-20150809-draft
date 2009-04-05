# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/log4net/log4net-1.2.10-r3.ebuild,v 1.1 2009/04/05 14:47:50 loki_val Exp $

EAPI=2

inherit eutils mono versionator

PV_MAJOR=$(get_version_component_range 1-2)

DESCRIPTION="tool to help the programmer output log statements to a variety of output targets."
HOMEPAGE="http://logging.apache.org/log4net/"
SRC_URI="mirror://debian/pool/main/l/log4net/log4net_1.2.10+dfsg.orig.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-lang/mono-2.0"
DEPEND="${RDEPEND}"

src_compile() {
	/usr/bin/gmcs \
		-t:library \
		-out:log4net.dll \
		-keyfile:"${FILESDIR}"/log4net.snk \
		-r:System.Data \
		-r:System.Web \
		$(find src -name "*.cs") || die
}

src_install() {
	egacinstall log4net.dll
	dodir /usr/$(get_libdir)/pkgconfig
	sed -e "s:@VERSION@:${PV}:" \
		-e "s:@LIBDIR@:$(get_libdir):" \
		-e "s:@NET_VERSION@:2.0:" \
		"${FILESDIR}"/${PN}.pc.in-r1 > "${D}"/usr/$(get_libdir)/pkgconfig/${PN}-${PV}.pc
	dosym ${PN}-${PV}.pc /usr/$(get_libdir)/pkgconfig/${PN}-${PV_MAJOR}.pc
	dosym ${PN}-${PV}.pc /usr/$(get_libdir)/pkgconfig/${PN}.pc

	dodoc README.txt NOTICE.txt
}
