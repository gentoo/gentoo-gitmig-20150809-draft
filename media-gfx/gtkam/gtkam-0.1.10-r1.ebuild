# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gtkam/gtkam-0.1.10-r1.ebuild,v 1.4 2004/02/16 08:53:50 absinthe Exp $

IUSE="nls gnome jpeg"

S=${WORKDIR}/${P}
DESCRIPTION="A frontend for gPhoto 2"
HOMEPAGE="http://gphoto.org/proj/gtkam"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64"

RDEPEND=">=x11-libs/gtk+-2
	>=media-libs/libgphoto2-2.1.1-r2
	gnome? ( >=gnome-base/libbonobo-2
		>=gnome-base/libgnomeui-2 )
	jpeg? ( media-libs/libexif-gtk
		media-libs/libexif )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-norpm.patch
}

src_compile() {

	local myconf

	myconf="--with-rpmbuild=/bin/false --without-gimp"

	use jpeg \
		&& myconf="${myconf} --with-exif" \
		|| myconf="${myconf} --without-exif"

	use gnome \
		&& myconf="${myconf} --with-gnome --with-bonobo" \
		|| myconf="${myconf} --without-gnome --without-bonobo"

	econf ${myconf} `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die
	rm -rf ${D}/usr/share/doc/gtkam
	dodoc ABOUT-NLS AUTHORS COPYING INSTALL MANUAL NEWS README
}
