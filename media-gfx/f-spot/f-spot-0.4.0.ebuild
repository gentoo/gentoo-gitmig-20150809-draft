# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/f-spot/f-spot-0.4.0.ebuild,v 1.1 2007/08/23 00:39:06 metalgod Exp $

inherit gnome2 mono eutils autotools

DESCRIPTION="Personal photo management application for the gnome desktop"
HOMEPAGE="http://f-spot.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.1.10
	>=dev-libs/dbus-glib-0.71
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2.6
	>=dev-dotnet/gtk-sharp-2.7
	>=dev-dotnet/gtkhtml-sharp-2.7
	>=dev-dotnet/gconf-sharp-2.7
	>=dev-dotnet/glade-sharp-2.7
	>=dev-dotnet/gnomevfs-sharp-2.7
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2
	>=media-libs/libexif-0.6
	<media-libs/libexif-0.7.0
	>=media-libs/libgphoto2-2.1.4
	>=media-libs/lcms-1.14
	media-libs/jpeg
	>=dev-db/sqlite-3"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# Gentoo used old so version until libexif-0.6.13-r2
	if has_version "<media-libs/libexif-0.6.13-r2";
	then
	sed -i -e 's/EXIF_SOVERSION=12/EXIF_SOVERSION=10/' configure.in
	fi
	# Multilib fix
	sed -i -e 's:prefix mono`/lib:libdir mono`:' \
		configure.in || die "sed failed"

	#older versions put headers in wrong spot, see #100269
	if has_version "<=media-libs/lcms-1.13-r1" || has_version "=media-libs/lcms-1.14"; then
		sed -i "s:lcms.h:lcms/lcms.h:" ${S}/configure.in || die "sed failed"
		sed -i "s:lcms.h:lcms/lcms.h:" ${S}/libeog/image-view.c || die "sed failed"
	fi

	eautoconf || die "autoconf failed"
}
