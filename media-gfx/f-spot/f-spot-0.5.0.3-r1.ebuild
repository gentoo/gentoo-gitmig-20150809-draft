# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/f-spot/f-spot-0.5.0.3-r1.ebuild,v 1.2 2009/02/01 16:31:17 loki_val Exp $

EAPI=2

inherit gnome2 mono eutils

DESCRIPTION="Personal photo management application for the gnome desktop"
HOMEPAGE="http://f-spot.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-2.0
	>=dev-libs/dbus-glib-0.71
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2.6
	>=dev-dotnet/gtk-sharp-2.12.0
	>=dev-dotnet/glade-sharp-2.12.0
	>=dev-dotnet/dbus-sharp-0.4.2
	>=dev-dotnet/dbus-glib-sharp-0.3.0
	>=dev-dotnet/gtkhtml-sharp-2.7
	>=dev-dotnet/gconf-sharp-2.7
	>=dev-dotnet/gnomevfs-sharp-2.7
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2
	>=media-libs/libexif-0.6.16
	<media-libs/libexif-0.7.0
	>=media-libs/libgphoto2-2.1.4
	>=media-libs/lcms-1.15
	media-libs/jpeg
	>=dev-db/sqlite-3"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

MAKEOPTS="${MAKEOPTS} -j1"

# See bug #203566
RESTRICT="test"

src_unpack() {
	default
}

src_prepare() {
	# Prevent scrollkeeper access violations
	gnome2_omf_fix

	# Run libtoolize
	elibtoolize ${ELTCONF}


	# http://bugs.gentoo.org/show_bug.cgi?id=252636
	# http://bugzilla.gnome.org/565733
	sed -i -e '/rm \-f $(pl/d' \
		$(
			grep -lr --include='Makefile.in' \
			'rm -f \$(pl' "${S}"/extensions/Exporters
		) || die "sed failed"
	epatch ${FILESDIR}/f-spot-0.5.0.3-icon-size-crash-fix.patch
	epatch ${FILESDIR}/f-spot-0.5.0.3-no-image-in-collection-crash-fix.patch
}

src_configure() {
	gnome2_src_configure --disable-static
}

src_compile () {
	default
}

src_install() {
	gnome2_src_install
	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
