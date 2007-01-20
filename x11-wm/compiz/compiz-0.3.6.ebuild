# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/compiz/compiz-0.3.6.ebuild,v 1.2 2007/01/20 04:32:07 hanno Exp $

inherit eutils gnome2

DESCRIPTION="compiz 3D composite- and windowmanager"
HOMEPAGE="http://www.go-compiz.org/"
SRC_URI="http://xorg.freedesktop.org/archive/individual/app/${P}.tar.bz2"
LICENSE="X11"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dbus gnome kde svg"

DEPEND=">=media-libs/mesa-6.5.1-r1
	>=media-libs/glitz-0.5.6
	>=x11-base/xorg-server-1.1.1-r1
	x11-libs/libXdamage
	x11-libs/libXrandr
	x11-libs/libXcomposite
	x11-libs/libXinerama
	media-libs/libpng
	>=x11-libs/gtk+-2.0
	x11-libs/startup-notification
	gnome? ( >=x11-libs/libwnck-2.16.1
		>=gnome-base/control-center-2.16.1 )
	svg? ( gnome-base/librsvg )
	dbus? ( >=sys-apps/dbus-1.0
		>dev-libs/glib-2
		kde? ( dev-libs/dbus-qt3-old ) )
	kde? (
	|| ( kde-base/kwin kde-base/kdebase )
	)"

src_compile() {
	econf --with-default-plugins \
		--enable-gtk \
		`use_enable gnome` \
		`use_enable gnome metacity` \
		`use_enable gnome gconf` \
		`use_enable kde` \
		`use_enable svg librsvg` \
		`use_enable dbus` \
		`use_enable dbus dbus-glib` || die

	emake || die
}

src_install() {
	dobin ${FILESDIR}/${PV}/compiz-start

	gnome2_src_install
}
