# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/galeon/galeon-2.0.7-r2.ebuild,v 1.3 2010/07/18 13:06:04 fauli Exp $

EAPI="2"
inherit autotools gnome2 eutils

DESCRIPTION="A GNOME Web browser based on gecko (mozilla's rendering engine)"
HOMEPAGE="http://galeon.sourceforge.net"
SRC_URI="mirror://sourceforge/galeon/${P}.tar.bz2
	mirror://gentoo/${P}-patches-r1.tar.bz2"

LICENSE="GPL-2"
IUSE=""
KEYWORDS="~amd64 ~ia64 ~ppc -sparc x86"
SLOT="0"
RDEPEND=">=net-libs/xulrunner-1.9.2
	>=x11-libs/gtk+-2.12.0
	>=dev-libs/libxml2-2.6.6
	>=gnome-base/libgnomeui-2.5.2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/gnome-desktop-2.10.0
	>=gnome-base/libglade-2.3.1"
DEPEND="${RDEPEND}
	app-text/rarian
	dev-util/pkgconfig
	>=dev-util/intltool-0.30
	>=sys-devel/gettext-0.11"

DOCS="AUTHORS ChangeLog FAQ README README.ExtraPrefs THANKS TODO NEWS"

src_prepare() {
	gnome2_src_prepare
	cd "${S}"

	for i in "${WORKDIR}/${P}-patches-r1/*"; do
		epatch $i || die "patch $i failed"
	done

	sed -i s/libxul-embedding-unstable/libxul/ configure.in || die
	sed -i s/TextZoom/FullZoom/ mozilla/GaleonWrapper.cpp || die
	eautoreconf
}

src_configure() {
	myconf="--with-mozilla=libxul"
	econf ${myconf} || die "configure failed"
}

src_compile() {
	emake MOZILLA_HOME="$(pkg-config libxul --variable=sdkdir)"/bin || die "compile failed"
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog
	elog "If after updating Galeon it becomes unable to show any webpage try"
	elog "removing old compreg.dat file:"
	elog " rm ~/.galeon/mozilla/galeon/compreg.dat"
	elog "and restart it."
}
