# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodoc/monodoc-0.17.ebuild,v 1.3 2004/10/26 21:53:58 latexer Exp $

inherit mono

DESCRIPTION="Documentation for mono's .Net class library"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://www.go-mono.com/archive/beta3/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=dev-dotnet/mono-0.96
		>=dev-dotnet/gtk-sharp-0.98"

src_compile() {
	econf || die
	MAKEOPTS="-j1"
	make || {
		echo
		ewarn "If for some reason this fails, try adding 'gtkhtml' to your USE variables, re-emerge gtk-sharp, then emerge monodoc"
		die "make failed"
	}
}

src_install() {
	make DESTDIR=${D} install || die
}
