# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pnet/pnet-0.5.8.ebuild,v 1.2 2003/06/18 10:44:32 scandium Exp $

DESCRIPTION="Portable .NET runtime, compiler, tools"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu-pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND=">=dev-util/treecc-0.2.4"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README 
	dodoc doc/gtk-sharp.HOWTO doc/*html

	# init script
	exeinto /etc/init.d ; newexe ${PORTDIR}/dev-lang/mono/files/dotnet.init dotnet
	insinto /etc/conf.d ; newins ${PORTDIR}/dev-lang/mono/files/dotnet.conf dotnet
}

pkg_postinst() {
	echo
	einfo "If you want to avoid typing '<runtime> program.exe'"
	einfo "you can configure your runtime in /etc/conf.d/dotnet"
	einfo "Use /etc/init.d/dotnet to register your runtime"
	echo
}
