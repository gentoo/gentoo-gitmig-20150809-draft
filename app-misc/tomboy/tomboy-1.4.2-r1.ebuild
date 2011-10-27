# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tomboy/tomboy-1.4.2-r1.ebuild,v 1.8 2011/10/27 06:02:25 tetromino Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2 mono eutils

DESCRIPTION="Desktop note-taking application"
HOMEPAGE="http://projects.gnome.org/tomboy/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="+applet eds galago"

RDEPEND=">=dev-lang/mono-2
	>=dev-dotnet/gtk-sharp-2.12.6-r1:2
	>=dev-dotnet/gconf-sharp-2.24.0:2
	>=dev-dotnet/gnome-sharp-2.24.0:2
	>=dev-dotnet/ndesk-dbus-0.4
	>=dev-dotnet/ndesk-dbus-glib-0.3
	>=dev-dotnet/mono-addins-0.3[gtk]
	>=x11-libs/gtk+-2.12.0:2
	>=dev-libs/atk-1.2.4
	>=gnome-base/gconf-2:2
	>=app-text/gtkspell-2.0.9:2
	applet? (
		|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
		>=dev-dotnet/gnome-panel-sharp-2.24.0:2 )
	eds? ( dev-libs/gmime:2.4[mono] )
	galago? ( =dev-dotnet/galago-sharp-0.5* )"
DEPEND="${RDEPEND}
	>=app-text/gnome-doc-utils-0.17.3
	app-text/rarian
	dev-libs/libxml2:2[python]
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.35"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable applet panel-applet)
		$(use_enable eds evolution)
		$(use_enable galago)
		--disable-update-mimedb"
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	gnome2_src_prepare

	# Fix tomboy insecure LD_LIBRARY_PATH (CVE-2010-4005)
	epatch "${FILESDIR}/${P}-insecure-path.patch"
}

src_compile() {
	# Not parallel build safe due upstream bug #631546
	MAKEOPTS="${MAKEOPTS} -j1" gnome2_src_compile
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die "remove of la files failed"
}
