# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gtkam/gtkam-0.1.12-r2.ebuild,v 1.5 2006/03/09 23:53:48 agriffis Exp $

inherit eutils gnome2

DESCRIPTION="A frontend for gPhoto 2"
HOMEPAGE="http://gphoto.org/proj/gtkam"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ~ppc sparc ~x86"
IUSE="exif gnome nls"

RDEPEND=">=x11-libs/gtk+-2
	>=media-libs/libgphoto2-2.1.6
	exif? ( media-libs/libexif-gtk media-libs/libexif )
	gnome? ( >=gnome-base/libbonobo-2 >=gnome-base/libgnomeui-2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS="ABOUT-NLS AUTHORS MANUAL NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable nls) $(use_enable exif) $(use_with gnome) \
			$(use_with gnome bonobo) --with-rpmbuild=/bin/false --without-gimp"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-0.1.10-norpm.patch
	epatch ${FILESDIR}/${PN}-0.1.12-helpdoc.patch
	epatch ${FILESDIR}/${PN}-0.1.12-desktop-image.patch
}

src_install() {
	gnome2_src_install
	rm -rf ${D}/usr/share/doc/gtkam
}
