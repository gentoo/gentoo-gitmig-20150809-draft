# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tomboy/tomboy-1.6.1.ebuild,v 1.3 2011/06/21 13:48:52 phajdan.jr Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"

inherit gnome2 mono

DESCRIPTION="Desktop note-taking application"
HOMEPAGE="http://projects.gnome.org/tomboy/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="+applet eds galago"

RDEPEND="app-text/gtkspell
	dev-dotnet/gconf-sharp:2
	dev-dotnet/gtk-sharp:2
	dev-dotnet/mono-addins[gtk]
	dev-dotnet/ndesk-dbus
	dev-dotnet/ndesk-dbus-glib
	dev-lang/mono
	dev-libs/atk
	gnome-base/gconf:2
	x11-libs/gtk+:2
	applet? ( dev-dotnet/gnome-sharp:2
		dev-dotnet/gnome-panel-sharp:2
		gnome-base/gnome-panel[bonobo] )
	eds? ( dev-libs/gmime:2.4[mono] )
	galago? ( dev-dotnet/galago-sharp )"
DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	app-text/rarian
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable applet panel-applet)
		$(use_enable eds evolution)
		$(use_enable galago)
		--disable-update-mimedb"
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_compile() {
	# Not parallel build safe due upstream bug #631546
	MAKEOPTS="${MAKEOPTS} -j1" gnome2_src_compile
}
