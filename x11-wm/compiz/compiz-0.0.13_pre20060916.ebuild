# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/compiz/compiz-0.0.13_pre20060916.ebuild,v 1.1 2006/09/16 14:21:20 hanno Exp $

inherit eutils autotools

SRC_URI="http://www.schokokeks.org/~hanno/snapshots/${PN}-${PV##*_pre}.tar.bz2"

PATCHES="${FILESDIR}/03-composite-cube-logo.patch
	${FILESDIR}/04-fbconfig-depth-fix.patch
	${FILESDIR}/06-glfinish.patch
	${FILESDIR}/07-cow.patch"

S=${WORKDIR}/${PN}

DESCRIPTION="compiz 3D composite- and windowmanager"
HOMEPAGE="http://en.opensuse.org/Compiz"
LICENSE="X11"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dbus svg"

DEPEND=">=media-libs/mesa-6.5.1
	>=media-libs/glitz-0.5.6
	>=x11-base/xorg-server-1.1.1-r1
	x11-libs/startup-notification
	media-libs/libpng
	x11-libs/libXdamage
	x11-libs/libXrandr
	x11-libs/libXcomposite
	x11-libs/libwnck
	gnome-base/gnome-desktop
	gnome-base/control-center
	svg? ( gnome-base/librsvg )
	dbus? ( sys-apps/dbus )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${PATCHES}
}

src_compile() {
	eautoreconf || die
	glib-gettextize --copy --force || die

	econf --with-gl-libs="-Wl,-R/usr/$(get_libdir)/opengl/xorg-x11/lib/ -lGL" \
		--disable-kde \
		--enable-gnome \
		`use_enable svg librsvg` \
		`use_enable dbus` || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dobin ${FILESDIR}/compiz-aiglx
}
