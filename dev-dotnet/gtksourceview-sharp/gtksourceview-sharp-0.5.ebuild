# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtksourceview-sharp/gtksourceview-sharp-0.5.ebuild,v 1.1 2004/06/30 15:36:27 latexer Exp $

inherit mono

DESCRIPTION="A C# Binding to gtksourceview"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/1.0/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND=">=dev-dotnet/mono-1.0
		>=x11-libs/gtk-sharp-1.0
		>=x11-libs/gtksourceview-1.0.0"

src_unpack() {
	unpack ${A}
	sed -i "s:\`monodoc:${D}\`monodoc:" ${S}/doc/Makefile.in
}

src_compile() {
	econf || die "./configure failed!"
	MAKEOPTS="-j1" make || die "make failed"
}

src_install() {
	dodir $(monodoc --get-sourcesdir)
	make GACUTIL_FLAGS="/root ${D}/usr/lib /gacdir /usr/lib -package gtk-sharp" \
		DESTDIR=${D} install || die
}
