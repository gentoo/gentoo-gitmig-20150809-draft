# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pnet/pnet-0.6.4.ebuild,v 1.2 2004/03/23 17:39:29 scandium Exp $

DESCRIPTION="Portable .NET runtime, compiler, tools"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu/pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips ~alpha ~hppa ~amd64 ~ia64"

IUSE=""

DEPEND=">=dev-util/treecc-0.3.0
	!dev-dotnet/mono"

src_compile() {
	econf || die
	MAKEOPTS="${MAKEOPTS} -j1" emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README
	dodoc doc/gtk-sharp.HOWTO
	dohtml doc/*.html

	# init script
	exeinto /etc/init.d ; newexe ${PORTDIR}/dev-dotnet/mono/files/dotnet.init dotnet
	insinto /etc/conf.d ; newins ${PORTDIR}/dev-dotnet/mono/files/dotnet.conf dotnet
}

pkg_postinst() {
	echo
	einfo "If you want to avoid typing '<runtime> program.exe'"
	einfo "you can configure your runtime in /etc/conf.d/dotnet"
	einfo "Use /etc/init.d/dotnet to register your runtime"
	echo
}
