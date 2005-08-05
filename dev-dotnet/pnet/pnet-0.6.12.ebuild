# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pnet/pnet-0.6.12.ebuild,v 1.8 2005/08/05 14:26:13 ferdy Exp $

DESCRIPTION="Portable.NET runtime, compiler, tools"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu/pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ppc ppc64 x86"
IUSE=""

DEPEND=">=dev-util/treecc-0.3.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Fix symlink for renamed executables
	sed -i "s:ilasm.1.gz:ilasm.pnet.1.gz:" ilasm/Makefile.am
	sed -i "s:al.1.gz:al.pnet.1.gz:" ilasm/Makefile.am
}

src_compile() {
	./auto_gen.sh
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	# Rename file names conflicting with dev-lang/mono
	# This should be removed again once we have 'dotnet-config'
	# bug 39369
	mv ${D}/usr/bin/al ${D}/usr/bin/al.pnet
	mv ${D}/usr/bin/ilasm ${D}/usr/bin/ilasm.pnet
	mv ${D}/usr/bin/resgen ${D}/usr/bin/resgen.pnet
	mv ${D}/usr/share/man/man1/ilasm.1 ${D}/usr/share/man/man1/ilasm.pnet.1
	mv ${D}/usr/share/man/man1/resgen.1 ${D}/usr/share/man/man1/resgen.pnet.1

	dodoc AUTHORS ChangeLog HACKING INSTALL NEWS README
	dodoc doc/gtk-sharp.HOWTO
	dohtml doc/*.html

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
	einfo "dev-dotnet/pnet is only the runtime, compiler and tools"
	einfo "for DotGNU Portable.NET."
	einfo "For running and developing applications that use .NET APIs"
	einfo "you will also need to install the library: dev-dotnet/pnetlib"
	echo
}
