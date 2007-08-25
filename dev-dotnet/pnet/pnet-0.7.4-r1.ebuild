# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pnet/pnet-0.7.4-r1.ebuild,v 1.5 2007/08/25 22:41:32 vapier Exp $

inherit autotools

DESCRIPTION="Portable.NET runtime, compiler, tools"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="http://www.southern-storm.com.au/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 arm hppa ~ia64 ppc ~ppc64 x86"
IUSE=""

DEPEND=">=dev-util/treecc-0.3.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix symlink for renamed executables ; Bug #39369
	# Renamed to avoid conflicting with dev-lang/mono
	# This should be removed again once we have 'dotnet-config'
	sed -i "s:ilasm.1.gz:ilasm.pnet.1.gz:" ilasm/Makefile.am
	sed -i "s:al.1.gz:al.pnet.1.gz:" ilasm/Makefile.am

	eautoreconf || die "eautoreconf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# move fixes for the mono conflict
	mv ${D}/usr/bin/al ${D}/usr/bin/al.pnet
	mv ${D}/usr/bin/ilasm ${D}/usr/bin/ilasm.pnet
	mv ${D}/usr/bin/resgen ${D}/usr/bin/resgen.pnet
	mv ${D}/usr/share/man/man1/ilasm.1 ${D}/usr/share/man/man1/ilasm.pnet.1
	mv ${D}/usr/share/man/man1/resgen.1 ${D}/usr/share/man/man1/resgen.pnet.1

	# move fixes to prevent boehm-gc collisions
	# bug 187379
	mv ${D}/usr/share/gc ${D}/usr/share/libgc-pnet

	dodoc AUTHORS ChangeLog HACKING NEWS README
	dodoc doc/gtk-sharp.HOWTO
	dohtml doc/*.html
}
