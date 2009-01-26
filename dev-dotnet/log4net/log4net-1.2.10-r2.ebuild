# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/log4net/log4net-1.2.10-r2.ebuild,v 1.1 2009/01/26 17:26:13 loki_val Exp $

EAPI=2

inherit eutils mono versionator

PV_MAJOR=$(get_version_component_range 1-2)

DESCRIPTION="tool to help the programmer output log statements to a variety of output targets."
HOMEPAGE="http://logging.apache.org/log4net/"
SRC_URI="mirror://debian/pool/main/l/log4net/log4net_1.2.10+dfsg.orig.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc examples"

RDEPEND=">=dev-lang/mono-2.0"
DEPEND="${RDEPEND}
	>=dev-dotnet/nant-0.85"

pkg_setup() {
	unset doc examples
	use doc && doc=yes
	use examples && examples=yes
}

src_prepare() {
	cp "${FILESDIR}"/log4net.snk ./
}

src_compile() {
	nant \
		-t:mono-2.0 -D:package.version=${PV} compile-mono-2.0	\
		check-package-dir check-package-version			\
		set-package-configuration  ${doc+package-doc}		\
		${examples+package-examples} || die "build failed"
}

src_install() {
	egacinstall bin/mono/2.0/debug/log4net.dll
	dodir /usr/$(get_libdir)/pkgconfig
	sed -e "s:@VERSION@:${PV}:" \
		-e "s:@LIBDIR@:$(get_libdir):" \
		-e "s:@NET_VERSION@:2.0:" \
		"${FILESDIR}"/${PN}.pc.in-r1 > "${D}"/usr/$(get_libdir)/pkgconfig/${PN}-${PV}.pc
	dosym ${PN}-${PV}.pc /usr/$(get_libdir)/pkgconfig/${PN}-${PV_MAJOR}.pc
	dosym ${PN}-${PV}.pc /usr/$(get_libdir)/pkgconfig/${PN}.pc

	use doc && dohtml -r build/package/log4net-1.2.10/doc/*
	if use examples
	then
		insinto /usr/share/doc/${PF}
		doins -r build/package/log4net-1.2.10/examples/
	fi
	dodoc README.txt NOTICE.txt
}
