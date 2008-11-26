# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tomboy/tomboy-0.12.1.ebuild,v 1.1 2008/11/26 01:04:23 loki_val Exp $

inherit eutils gnome2 mono

DESCRIPTION="Desktop note-taking application"
HOMEPAGE="http://www.beatniksoftware.com/tomboy/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 -ppc ~x86"
IUSE="doc eds galago"

RDEPEND=">=dev-lang/mono-1.9
		 >=dev-dotnet/gtk-sharp-2.10.4
		 >=dev-dotnet/gconf-sharp-2
		 >=dev-dotnet/gnome-sharp-2.16.1
		 >=dev-dotnet/dbus-sharp-0.4
		 >=dev-dotnet/dbus-glib-sharp-0.3
		 >=dev-dotnet/mono-addins-0.3
		 >=x11-libs/gtk+-2.10.0
		 >=dev-libs/atk-1.2.4
		 >=gnome-base/gconf-2
		 >=app-text/gtkspell-2.0.9
		 >=gnome-base/gnome-panel-2.8.2
		 eds? ( dev-libs/gmime )
		 galago? ( =dev-dotnet/galago-sharp-0.5* )
		 >=gnome-base/libgnomeprintui-2.18.3"
DEPEND="${RDEPEND}
		  dev-libs/libxml2
		  sys-devel/gettext
		  dev-util/pkgconfig
		>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"

pkg_setup() {
	if ! built_with_use 'dev-libs/libxml2' 'python' ; then
		eerror "Please build libxml2 with the python USE-flag"
		einfo "echo \"dev-libs/libxml2 python\" >> /etc/portage/package.use"
		die "dev-libs/libxml2 without python bindings detected"
	fi

	if use eds && ! built_with_use 'dev-libs/gmime' mono ; then
		eerror "Please build gmime with the mono USE-flag"
		einfo "echo \"dev-libs/gmime mono\" >> /etc/portage/package.use"
		die "gmime without mono support detected"
	fi

	G2CONF="${G2CONF} $(use_enable galago) $(use_enable eds evolution) --with-mono-addins=system"
}
