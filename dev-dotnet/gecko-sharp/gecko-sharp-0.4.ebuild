# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gecko-sharp/gecko-sharp-0.4.ebuild,v 1.1 2004/06/02 16:06:57 latexer Exp $

inherit mono

DESCRIPTION="A Gtk# Mozilla binding"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/beta2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=dev-dotnet/mono-0.95
		>=x11-libs/gtk-sharp-0.93
		net-www/mozilla"

src_compile() {
	econf || die "./configure failed!"
	MAKEOPTS="-j1" make || die "Make failed. You may need to unmerge gecko-sharp and re-emerge it if you are upgrading from an earlier version."
}

src_install() {
	make DESTDIR=${D} install || die
}
