# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/blam/blam-1.6.1.ebuild,v 1.1 2005/01/12 23:24:24 latexer Exp $

inherit mono gnome2 eutils

DESCRIPTION="A RSS aggregator written in C#"
HOMEPAGE="http://www.imendio.com/projects/blam/"
SRC_URI="http://ftp.imendio.com/pub/imendio/${PN}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""
DEPEND=">=dev-dotnet/mono-1.0
		>=dev-dotnet/gtk-sharp-1.0.4-r1
		>=dev-dotnet/gconf-sharp-1.0.4
		>=dev-dotnet/glade-sharp-1.0.4
		>=dev-dotnet/gecko-sharp-0.6
		>=gnome-base/gconf-2.4"

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
