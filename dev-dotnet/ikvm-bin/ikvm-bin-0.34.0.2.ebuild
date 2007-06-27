# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ikvm-bin/ikvm-bin-0.34.0.2.ebuild,v 1.1 2007/06/27 02:02:24 jurek Exp $

inherit eutils mono multilib

MY_P=${P/-bin/}
MY_PN=${PN/-bin/}

DESCRIPTION="Java VM for .NET"
HOMEPAGE="http://www.ikvm.net/"
SRC_URI="http://www.go-mono.com/sources/${MY_PN}/${MY_PN}bin-${PV}.zip"

LICENSE="as-is"

SLOT="0"
S=${WORKDIR}/${MY_P}

KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/mono-1.1
		!dev-dotnet/ikvm
		app-arch/unzip"
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/$(get_libdir)/${MY_PN}
	doins bin/*

	for exe in ikvm ikvmc ikvmstub;
	do
		make_wrapper ${exe} "mono /usr/$(get_libdir)/${MY_PN}/${exe}.exe"
	done

	dodir /usr/$(get_libdir)/pkgconfig
	sed -e "s:@VERSION@:${PV}:" \
		-e "s:@LIBDIR@:$(get_libdir):" \
		${FILESDIR}/${MY_PN}.pc.in > ${D}/usr/$(get_libdir)/pkgconfig/${MY_PN}.pc
}
