# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pnet/pnet-0.5.10.ebuild,v 1.5 2003/08/26 17:03:44 scandium Exp $

inherit eutils

DESCRIPTION="Portable .NET runtime, compiler, tools"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu-pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND=">=dev-util/treecc-0.2.6
	!dev-dotnet/mono"

src_unpack() {
# Fix a pnetc compile problem

        unpack ${A}
        cd ${S}
        epatch ${FILESDIR}/md5hash.patch
	./auto_gen.sh || die
}

src_compile() {
	econf || die
	emake || die
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
