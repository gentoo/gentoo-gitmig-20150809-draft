# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/nini/nini-1.1.0-r1.ebuild,v 1.2 2009/01/07 22:04:05 mr_bones_ Exp $

EAPI=2

inherit mono multilib

DESCRIPTION="Nini - A configuration library for .NET"
HOMEPAGE="http://nini.sourceforge.net"
SRC_URI="mirror://sourceforge/nini/Nini-${PV}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-lang/mono-2"
DEPEND="${RDEPEND}
	app-arch/sharutils
	sys-apps/sed"

S=${WORKDIR}/Nini/Source

src_prepare() {
	uudecode -o Nini.snk "${FILESDIR}"/Nini.snk.uue
}

src_configure() {
	use debug&&DEBUG="-debug"
}

src_compile() {
	#See nini in Debian for info
	gmcs	${DEBUG} \
		-nowarn:1616 \
		-target:library \
		-out:Nini.dll \
		-define:STRONG \
		-r:System.dll \
		-r:System.Xml.dll \
		-keyfile:Nini.snk \
		AssemblyInfo.cs Config/*.cs Ini/*.cs Util/*.cs \
		|| die "Compilation failed"

	sed 	\
		-e 's|@prefix@|${pcfiledir}/../..|' \
		-e 's|@exec_prefix@|${prefix}|' \
		-e "s|@libdir@|\$\{exec_prefix\}/$(get_libdir)|" \
		-e "s|@libs@|-r:\$\{libdir\}/mono/Nini/Nini.dll|" \
		-e "s|@VERSION@|${PV}|" \
		"${FILESDIR}"/nini.pc.in > "${S}"/nini.pc
}

src_install() {
	egacinstall Nini.dll Nini
	insinto /usr/$(get_libdir)/pkgconfig
	doins "${S}"/nini.pc
	dodoc "${S}"/../CHANGELOG.txt "${S}"/../README.txt
}
