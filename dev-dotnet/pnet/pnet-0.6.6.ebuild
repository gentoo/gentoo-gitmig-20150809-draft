# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pnet/pnet-0.6.6.ebuild,v 1.9 2004/08/08 10:09:46 scandium Exp $

inherit eutils flag-o-matic

DESCRIPTION="Portable .NET runtime, compiler, tools"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu/pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64"
IUSE=""

DEPEND=">=dev-util/treecc-0.3.0
	!dev-dotnet/mono"

src_unpack() {
	# Patch to fix compilation on 64 bit architectures
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/verify_branch.c.patch
}

src_compile() {
	has_version '=sys-devel/gcc-3.4*' && replace-flags -O? -O1
	econf || die
	emake -j1 || die
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog HACKING INSTALL NEWS README
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
