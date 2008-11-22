# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mcatalog/mcatalog-0.2.ebuild,v 1.3 2008/11/22 23:25:11 loki_val Exp $

EAPI=2

inherit mono

DESCRIPTION="Application written using mono and GTK# for cataloguing movies and books"
HOMEPAGE="http://mcatalog.sourceforge.net/"
SRC_URI="http://www.${PN}.net/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="doc"
DEPEND=">=dev-lang/mono-1.0
		>=dev-dotnet/gecko-sharp-0.7
		>=dev-dotnet/evolution-sharp-0.6
		=dev-dotnet/gtkhtml-sharp-1.0*
		>=dev-dotnet/gtk-sharp-0.7
		>=dev-dotnet/gnome-sharp-2.0
		|| ( dev-dotnet/gtk-sharp[glade] >=dev-dotnet/glade-sharp-2.0 )
		>=dev-dotnet/gconf-sharp-2.0
		>=gnome-base/gconf-2.4
		=dev-db/sqlite-2.8*"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog INSTALL NEWS README || die "dodoc failed"
}
