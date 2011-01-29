# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/smuxi/smuxi-0.8.ebuild,v 1.3 2011/01/29 17:07:58 hwoarang Exp $

EAPI=2

inherit base mono eutils

DESCRIPTION="A flexible, irssi-like and user-friendly IRC client for the Gnome Desktop."
HOMEPAGE="http://www.smuxi.org/main/"
SRC_URI="http://www.smuxi.org/jaws/data/files/${P}.tar.gz"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug gnome libnotify"
LICENSE="|| ( GPL-2 GPL-3 )"

RDEPEND=">=dev-lang/mono-2.0
	>=dev-dotnet/smartirc4net-0.4.5.1
	>=dev-dotnet/nini-1.1.0-r2
	>=dev-dotnet/log4net-1.2.10-r2
	gnome? ( >=dev-dotnet/gtk-sharp-2.12
		 >=dev-dotnet/gconf-sharp-2.12
		 >=dev-dotnet/glade-sharp-2.12
		 >=dev-dotnet/glib-sharp-2.12 )
	libnotify? ( dev-dotnet/notify-sharp )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.25
	>=sys-devel/gettext-0.17
	>=dev-util/pkgconfig-0.23"

src_configure() {
	econf	--disable-dependency-tracking	\
		--enable-engine-irc		\
		--without-indicate		\
		$(use_enable debug)		\
		$(use_enable gnome frontend-gnome) \
		$(use_with libnotify notify)
}

src_compile() {
	# This is not parallel build safe, see upstream bug #515
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc FEATURES TODO README || die "dodoc failed"
}
