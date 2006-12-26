# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/compiz/compiz-0.3.4.ebuild,v 1.4 2006/12/26 18:51:39 hanno Exp $

inherit eutils gnome2

DESCRIPTION="compiz 3D composite- and windowmanager"
HOMEPAGE="http://www.go-compiz.org/"
SRC_URI="http://xorg.freedesktop.org/archive/individual/app/${P}.tar.bz2"
LICENSE="X11"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dbus svg"

DEPEND=">=media-libs/mesa-6.5.1-r1
	>=media-libs/glitz-0.5.6
	>=x11-base/xorg-server-1.1.1-r1
	x11-libs/libXdamage
	x11-libs/libXrandr
	x11-libs/libXcomposite
	x11-libs/libXinerama
	media-libs/libpng
	>=x11-libs/libwnck-2.16.1
	>=gnome-base/control-center-2.16.1
	svg? ( gnome-base/librsvg )
	dbus? ( sys-apps/dbus )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/06-glfinish.patch
}

src_compile() {
	econf --enable-gtk \
		--enable-gnome \
		--enable-gconf \
		--disable-kde \
		`use_enable svg librsvg` \
		`use_enable dbus` || die

	emake || die
}

src_install() {
	dobin ${FILESDIR}/compiz-{aiglx,xgl,nvidia,start}

	gnome2_src_install
}
