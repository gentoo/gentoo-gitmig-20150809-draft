# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gecko-sharp/gecko-sharp-0.5-r1.ebuild,v 1.2 2004/10/26 21:54:59 latexer Exp $

inherit mono

DESCRIPTION="A Gtk# Mozilla binding"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/beta3/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND=">=dev-dotnet/mono-0.97
		>=dev-dotnet/gtk-sharp-0.99
		net-www/mozilla"

src_unpack() {
	unpack ${A}

	# Build fix for mono RC1
	sed -i -e "s:mono:mono --optimize=loop:" \
		${S}/gtkmozembed/Makefile.in
}

src_compile() {
	econf || die "./configure failed!"
	MAKEOPTS="-j1" make || die "Make failed. You may need to unmerge gecko-sharp and re-emerge it if you are upgrading from an earlier version."
}

src_install() {
	make DESTDIR=${D} install || die
}
