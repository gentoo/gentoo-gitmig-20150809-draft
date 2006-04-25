# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tomboy/tomboy-0.3.5.ebuild,v 1.4 2006/04/25 19:40:19 compnerd Exp $

inherit gnome2 mono eutils

DESCRIPTION="Desktop note-taking application"
HOMEPAGE="http://www.beatniksoftware.com/tomboy/"
SRC_URI="http://www.beatniksoftware.com/tomboy/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc eds galago"

RDEPEND=">=dev-lang/mono-1.0
		 =dev-dotnet/gtk-sharp-1.0*
		 >=dev-dotnet/gtk-sharp-1.0.4-r1
		 =dev-dotnet/gnome-sharp-1.0*
		 >=dev-dotnet/gnome-sharp-1.0.4
		 =dev-dotnet/gconf-sharp-1.0*
		 >=dev-dotnet/gconf-sharp-1.0.4
		 eds? ( dev-libs/gmime )
		 galago? ( dev-dotnet/galago-sharp )
		 >=gnome-base/gconf-2
		 >=x11-libs/gtk+-2.6.0
		 >=dev-libs/atk-1.2.4
		 gnome-base/libgnomeprint
		 gnome-base/libgnomeprintui
		 >=gnome-base/gnome-panel-2.8.2
		 >=app-text/gtkspell-2
		 >=sys-apps/dbus-0.23
		 sys-devel/gettext
		 >=app-text/aspell-0.60.2"
DEPEND="${RDEPEND}
		>=dev-util/intltool-0.25
		dev-util/pkgconfig"

DOCS="AUTHORS Changelog INSTALL NEWS README"
USE_DESTDIR="1"

pkg_setup() {
	if ! built_with_use 'sys-apps/dbus' mono ; then
		eerror "Please build dbus with the mono USE-flag"
		die "dbus without mono support detected"
	fi

	if use eds && ! built_with_use 'dev-libs/gmime' mono ; then
		eerror "Please build gmime with the mono USE-flag"
		die "gmime without mono support detected"
	fi

	if [[ ${ARCH} ==  'ppc' ]] ; then
		G2CONF="${G2CONF} --disable-galago $(use_enable eds evolution)"
	else
		G2CONF="${G2CONF} $(use_enable galago) $(use_enable eds evolution)"
	fi
}
