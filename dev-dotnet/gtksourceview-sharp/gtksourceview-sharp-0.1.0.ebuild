# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtksourceview-sharp/gtksourceview-sharp-0.1.0.ebuild,v 1.1 2004/04/02 02:07:55 latexer Exp $

inherit mono

DESCRIPTION="A C# Binding to gtksourceview"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=dev-dotnet/mono-0.28
		>=x11-libs/gtk-sharp-0.18
		>=x11-libs/gtksourceview-0.7.0"

src_compile() {
	econf || die "./configure failed!"
	MAKEOPTS="-j1" make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
}

