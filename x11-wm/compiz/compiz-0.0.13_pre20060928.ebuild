# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/compiz/compiz-0.0.13_pre20060928.ebuild,v 1.1 2006/09/28 01:48:12 hanno Exp $

inherit eutils autotools

SRC_URI="http://www.schokokeks.org/~hanno/snapshots/${PN}-${PV##*_pre}.tar.bz2"

S=${WORKDIR}/${PN}

DESCRIPTION="compiz 3D composite- and windowmanager"
HOMEPAGE="http://en.opensuse.org/Compiz"
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
	media-libs/libpng
	x11-libs/libwnck
	gnome-base/control-center
	svg? ( gnome-base/librsvg )
	dbus? ( sys-apps/dbus )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/06-glfinish.patch
}

src_compile() {
	eautoreconf || die
	glib-gettextize --copy --force || die

	econf --enable-gtk \
		--enable-gnome \
		--enable-gconf \
		--disable-kde \
		`use_enable svg librsvg` \
		`use_enable dbus` || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dobin ${FILESDIR}/compiz-{aiglx,xgl,nvidia}
}
