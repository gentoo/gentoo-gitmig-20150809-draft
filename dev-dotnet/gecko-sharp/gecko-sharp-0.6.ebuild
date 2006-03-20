# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gecko-sharp/gecko-sharp-0.6.ebuild,v 1.14 2006/03/20 00:27:49 metalgod Exp $

inherit mono multilib

DESCRIPTION="A Gtk# Mozilla binding"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/1.0.3/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=dev-lang/mono-1.0
	=dev-dotnet/gtk-sharp-1.0*
	www-client/mozilla"

src_unpack() {
	unpack ${A}
	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e 's:^libdir.*:libdir=@libdir@:' \
			${S}/*.pc.in || die
	fi
}

src_compile() {
	econf || die "./configure failed!"
	emake -j1 || die "Make failed. You may need to unmerge gecko-sharp and re-emerge it if you are upgrading from an earlier version."
}

src_install() {
	make DESTDIR=${D} install || die
}
