# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gwget/gwget-0.94.ebuild,v 1.3 2005/07/15 21:26:42 agriffis Exp $

inherit eutils gnome2 libtool

DESCRIPTION="GTK2 WGet Frontend"
HOMEPAGE="http://gnome.org/projects/gwget/"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"

IUSE="epiphany"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND="net-misc/wget
	>=x11-libs/gtk+-2.4
	>=gnome-base/gconf-1.1.11
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	epiphany? ( >=www-client/epiphany-1.4 )
	>=dev-libs/glib-2.4.0
	"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.11
	dev-util/pkgconfig
	>=sys-devel/gettext-0.10.4
	"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO"

G2CONF="${G2CONF} $(use_enable epiphany epiphany-extension)"
USE_DESTDIR="1"

src_unpack() {
	unpack ${A}
	cd ${S}
	libtoolize --copy --force
	# Fix the Epiphany extension installation directory:
	epatch ${FILESDIR}/gwget-0.94-epiphany-path-fix.patch
}

src_install() {
	gnome2_src_install
	# remove /var/lib, which is created without any reason
	rm -rf ${D}/var
}
