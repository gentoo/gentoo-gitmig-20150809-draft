# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ikvm-bin/ikvm-bin-0.44.0.5.ebuild,v 1.1 2010/09/12 15:24:58 pacho Exp $

inherit eutils mono multilib

MY_P=${P/-bin/}
MY_PN=${PN/-bin/}

DESCRIPTION="Java VM for .NET"
HOMEPAGE="http://www.ikvm.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}bin-${PV}.zip"
LICENSE="as-is"

SLOT="0"
S=${WORKDIR}/${MY_P}

KEYWORDS="~amd64 ~x86"
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
