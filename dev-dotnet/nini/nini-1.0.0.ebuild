# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/nini/nini-1.0.0.ebuild,v 1.1 2005/11/08 06:00:05 compnerd Exp $

inherit mono multilib

DESCRIPTION="Nini - A configuration library for .NET"
HOMEPAGE="http://nini.sourceforge.net"
SRC_URI="mirror://sourceforge/nini/Nini-${PV}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.1.8"
DEPEND="${RDEPEND}
		app-arch/unzip
		dev-dotnet/nant
		dev-util/pkgconfig
		sys-apps/sed"

S=${WORKDIR}/Nini

src_unpack() {
	unpack ${A} || die "Unable to extract sources"

	cp ${FILESDIR}/nini-${PV}.build ${S}/nini.build
	cp ${FILESDIR}/nini.pc.in ${S}
}

src_compile() {
	nant || die "Failed to build"

	sed -e "s|@prefix@|/usr|" \
		-e 's|@exec_prefix@|${prefix}|' \
		-e "s|@libdir@|\$\{exec_prefix\}/$(get_libdir)/nini|" \
		-e "s|@libs@|-r:\$\{libdir\}/Nini.dll|" \
		-e "s|@VERSION@|${PV}|" \
		${S}/nini.pc.in > ${S}/nini.pc
}

src_install() {
	dodir /usr/$(get_libdir)/nini/
	insinto /usr/$(get_libdir)/nini/
	doins ${S}/build/Nini.dll

	insinto /usr/$(get_libdir)/pkgconfig/
	doins ${S}/nini.pc

	dodoc ${S}/CHANGELOG.txt ${S}/README.txt
}
