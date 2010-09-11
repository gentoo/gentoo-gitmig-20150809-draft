# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tomboy/tomboy-1.2.1.ebuild,v 1.6 2010/09/11 18:56:27 josejx Exp $

EAPI=2

inherit eutils gnome2 mono

DESCRIPTION="Desktop note-taking application"
HOMEPAGE="http://www.beatniksoftware.com/tomboy/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="eds galago"

RDEPEND=">=dev-lang/mono-2
	>=dev-dotnet/gtk-sharp-2.12.6-r1
	>=dev-dotnet/gconf-sharp-2.24.0
	>=dev-dotnet/gnome-sharp-2.24.0
	>=dev-dotnet/gnome-panel-sharp-2.24.0
	>=dev-dotnet/gnome-desktop-sharp-2.24.0
	>=dev-dotnet/dbus-sharp-0.4
	>=dev-dotnet/dbus-glib-sharp-0.3
	>=dev-dotnet/mono-addins-0.3
	>=x11-libs/gtk+-2.12.0
	>=dev-libs/atk-1.2.4
	>=gnome-base/gconf-2
	>=app-text/gtkspell-2.0.9
	>=gnome-base/gnome-panel-2.24.0
	eds? ( dev-libs/gmime:2.4[mono] )
	galago? ( =dev-dotnet/galago-sharp-0.5* )"
DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	app-text/rarian
	dev-libs/libxml2[python]
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-update-mimedb"
}

src_prepare() {
	gnome2_src_prepare

	sed -i -e '/DISABLE_DEPRECATED/d' $(find . -name 'Makefile.in') || die

	# Fix intltoolize broken file, see upstream #577133
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in \
		|| die "sed failed"

	# Fix xmllint validation, bug #330693
	epatch "${FILESDIR}/${P}-xmllint-validation.patch"
}

src_configure() {
	gnome2_src_configure $(use_enable galago) $(use_enable eds evolution)
}
