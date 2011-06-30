# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ikvm-bin/ikvm-bin-0.44.0.6.ebuild,v 1.3 2011/06/30 14:15:02 angelos Exp $

inherit eutils mono multilib

MY_P=${P/-bin/}
MY_PN=${PN/-bin/}

DESCRIPTION="Java VM for .NET"
HOMEPAGE="http://www.ikvm.net/ http://weblog.ikvm.net/"
SRC_URI="http://www.frijters.net/${MY_PN}bin-${PV}.zip"
LICENSE="as-is"

SLOT="0"
S=${WORKDIR}/${MY_P}

KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-lang/mono-1.1
		!dev-dotnet/ikvm
		app-arch/unzip"
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/$(get_libdir)/${MY_PN}
	doins bin/* || die "doins failed"

	for exe in ikvm ikvmc ikvmstub;
	do
		make_wrapper ${exe} "mono /usr/$(get_libdir)/${MY_PN}/${exe}.exe" || die
	done

	dodir /usr/$(get_libdir)/pkgconfig
	sed -e "s:@VERSION@:${PV}:" \
		-e "s:@LIBDIR@:$(get_libdir):" \
		"${FILESDIR}"/ikvm-0.36.0.5.pc.in > "${D}"/usr/$(get_libdir)/pkgconfig/${MY_PN}.pc \
		|| die "sed failed"

	for dll in bin/IKVM*.dll
	do
		gacutil -i ${dll} -root "${D}"/usr/$(get_libdir) \
			-gacdir /usr/$(get_libdir) -package ${dll} || die
	done
}
