# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/f-spot/f-spot-0.6.0.0.ebuild,v 1.1 2009/08/11 12:52:18 lack Exp $

EAPI=2

inherit gnome2 mono eutils autotools

DESCRIPTION="Personal photo management application for the gnome desktop"
HOMEPAGE="http://f-spot.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+gconf beagle"

RDEPEND=">=dev-lang/mono-2.0
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2
	>=media-libs/libexif-0.6.16
	<media-libs/libexif-0.7.0
	>=dev-dotnet/gtk-sharp-2.12.2
	>=dev-dotnet/glib-sharp-2.12.2
	>=dev-dotnet/glade-sharp-2.12.2
	>=dev-dotnet/gnomevfs-sharp-2.12.2
	>=x11-libs/gtk+-2.14
	>=dev-libs/glib-2.16
	>=dev-dotnet/gnome-sharp-2.8
	>=dev-dotnet/glib-sharp-2.12
	gconf? ( >=dev-dotnet/gconf-sharp-2.12.2 )
	beagle? ( >=app-misc/beagle-0.3.0 )
	>=dev-libs/dbus-glib-0.71
	>=dev-dotnet/dbus-sharp-0.4.2
	>=dev-dotnet/dbus-glib-sharp-0.3.0
	media-libs/jpeg
	>=media-libs/lcms-1.12
	>=media-libs/libgphoto2-2.1.4
	>=dev-db/sqlite-3"

DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	dev-util/pkgconfig
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

SCROLLKEEPER_UPDATE=0

src_prepare() {
	epatch "${FILESDIR}/${P}-parallel-build.patch"
	epatch "${FILESDIR}/${P}-sandbox-violation.patch"
	eautoreconf
}

src_configure() {
	gnome2_src_configure --disable-static --disable-scrollkeeper \
		$(use_enable gconf)
}

src_install() {
	gnome2_src_install
	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
