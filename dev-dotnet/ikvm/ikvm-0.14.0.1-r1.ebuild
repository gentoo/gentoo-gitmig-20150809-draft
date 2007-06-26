# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ikvm/ikvm-0.14.0.1-r1.ebuild,v 1.7 2007/06/26 23:53:10 jurek Exp $

inherit mono multilib

CLASSPATH_P="classpath-0.15"

DESCRIPTION="Java VM for .NET"
HOMEPAGE="http://www.ikvm.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip
		mirror://gnu/classpath/${CLASSPATH_P}.tar.gz"
LICENSE="as-is"

SLOT="0"
S=${WORKDIR}/${PN}
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.1"
DEPEND="${RDEPEND}
		!dev-dotnet/ikvm-bin
		>=dev-java/jikes-1.21
		>=dev-dotnet/nant-0.85_rc2
		app-arch/unzip"

src_compile() {
	nant || die "ikvm build failed"
}

src_install() {
	dodir /usr/bin
	for exe in ikvm ikvmc ikvmstub;
	do
		sed -e "s:EXE:${exe}:" \
			-e "s:P:${PN}:" \
			${FILESDIR}/script-template \
			> ${D}/usr/bin/${exe}
		fperms +x /usr/bin/${exe}
	done

	dodir /usr/$(get_libdir)/pkgconfig
	sed -e "s:@VERSION@:${PV}:" ${FILESDIR}/ikvm.pc.in \
		> ${D}/usr/$(get_libdir)/pkgconfig/ikvm.pc

	insinto /usr/$(get_libdir)/${PN}
	doins ${S}/bin/*
}
