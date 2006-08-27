# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tomboy/tomboy-0.3.9.ebuild,v 1.1 2006/08/27 23:01:33 compnerd Exp $

inherit gnome2 mono eutils

DESCRIPTION="Desktop note-taking application"
HOMEPAGE="http://www.beatniksoftware.com/tomboy/"
SRC_URI="http://www.beatniksoftware.com/tomboy/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc eds galago"

RDEPEND=">=dev-lang/mono-1.1
		 >=dev-dotnet/gtk-sharp-2
		 >=dev-dotnet/gconf-sharp-2
		 >=dev-dotnet/gnome-sharp-2
		 >=sys-apps/dbus-0.60
		 >=x11-libs/gtk+-2.6.0
		 >=dev-libs/atk-1.2.4
		 >=gnome-base/gconf-2
		 >=app-text/gtkspell-2.0.9
		 >=gnome-base/gnome-panel-2.8.2
		 >=gnome-base/libgnomeprint-2.2
		 >=gnome-base/libgnomeprintui-2.2
		 eds? ( dev-libs/gmime )
		 galago? ( =dev-dotnet/galago-sharp-0.5* )
		 >=app-text/aspell-0.60.2"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		  dev-util/pkgconfig
		>=dev-util/intltool-0.25"

DOCS="AUTHORS Changelog INSTALL NEWS README"

pkg_setup() {
	if use eds && ! built_with_use 'dev-libs/gmime' mono ; then
		eerror "Please build gmime with the mono USE-flag"
		die "gmime without mono support detected"
	fi

	G2CONF="${G2CONF} $(use_enable galago) $(use_enable eds evolution)"
}
