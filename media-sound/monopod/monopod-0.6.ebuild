# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/monopod/monopod-0.6.ebuild,v 1.8 2009/01/08 20:28:05 loki_val Exp $
EAPI=2

inherit mono eutils autotools

DESCRIPTION="A very lightweight podcast client with ipod support written in GTK#"
HOMEPAGE="http://monopod.berlios.de"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.1.6
	>=dev-dotnet/glade-sharp-2.8
	>=dev-dotnet/gnome-sharp-2.8
	>=dev-dotnet/gconf-sharp-2.8
	>=dev-dotnet/gtk-sharp-2.8
	dev-db/sqlite
	sys-apps/dbus"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build-fix.patch
	eautoreconf
}

src_configure() {
	econf --disable-ipod
}

src_install() {
	emake DESTDIR="${D}" install
}
