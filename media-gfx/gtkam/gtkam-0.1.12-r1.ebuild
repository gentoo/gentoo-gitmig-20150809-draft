# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gtkam/gtkam-0.1.12-r1.ebuild,v 1.1 2005/08/27 17:00:04 agriffis Exp $

inherit eutils gnome2

IUSE="exif gnome nls"

DESCRIPTION="A frontend for gPhoto 2"
HOMEPAGE="http://gphoto.org/proj/gtkam"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"

RDEPEND=">=x11-libs/gtk+-2
	>=media-libs/libgphoto2-2.1.6
	exif? ( media-libs/libexif-gtk media-libs/libexif )
	gnome? ( >=gnome-base/libbonobo-2 >=gnome-base/libgnomeui-2 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.1.10-norpm.patch
	epatch ${FILESDIR}/${PN}-0.1.12-helpdoc.patch
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_with exif) \
		$(use_with gnome gnome) \
		$(use_with gnome bonobo) \
		--with-rpmbuild=/bin/false --without-gimp
	emake || die
}

src_install() {
	einstall || die
	rm -rf ${D}/usr/share/doc/gtkam
	dodoc ABOUT-NLS AUTHORS COPYING INSTALL MANUAL NEWS README
}
