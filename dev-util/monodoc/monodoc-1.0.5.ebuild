# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodoc/monodoc-1.0.5.ebuild,v 1.7 2005/03/21 19:58:49 dholm Exp $

inherit mono

DESCRIPTION="Documentation for mono's .Net class library"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://www.go-mono.com/archive/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""
DEPEND=">=dev-lang/mono-1.0
		>=dev-dotnet/gtk-sharp-1.0.4-r1
		>=dev-dotnet/glade-sharp-1.0.4
		>=dev-dotnet/gtkhtml-sharp-1.0.4
		=dev-dotnet/gtk-sharp-1.0*
		=dev-dotnet/glade-sharp-1.0*
		=dev-dotnet/gtkhtml-sharp-1.0*"

src_compile() {
	econf || die
	MAKEOPTS="${MAKEOPTS} -j1"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
