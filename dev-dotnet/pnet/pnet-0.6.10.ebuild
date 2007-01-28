# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pnet/pnet-0.6.10.ebuild,v 1.9 2007/01/28 06:20:58 genone Exp $

DESCRIPTION="Portable. NET runtime, compiler, tools"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu/pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ppc ppc64 x86"
IUSE=""

DEPEND=">=dev-util/treecc-0.3.0
	!dev-lang/mono"

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog HACKING INSTALL NEWS README
	dodoc doc/gtk-sharp.HOWTO
	dohtml doc/*.html

	# init script
	exeinto /etc/init.d ; newexe ${FILESDIR}/dotnet.init dotnet
	insinto /etc/conf.d ; newins ${FILESDIR}/dotnet.conf dotnet
}

pkg_postinst() {
	echo
	elog "If you want to avoid typing '<runtime> program.exe'"
	elog "you can configure your runtime in /etc/conf.d/dotnet"
	elog "Use /etc/init.d/dotnet to register your runtime"
	echo
	elog "dev-dotnet/pnet is only the runtime, compiler and tools"
	elog "for DotGNU Portable.NET."
	elog "For running and developing applications that use .NET APIs"
	elog "you will also need to install the library: dev-dotnet/pnetlib"
	echo
}
