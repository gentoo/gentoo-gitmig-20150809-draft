# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-0.13.ebuild,v 1.8 2004/07/14 17:40:59 agriffis Exp $

IUSE="nls"

DESCRIPTION="gthumb is an Image Viewer and Browser for Gnome."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gthumb.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/gdk-pixbuf-0.11.0-r1
	=gnome-base/gnome-vfs-1.0*
	>=gnome-base/gnome-print-0.30
	>=dev-libs/libxml-1.8.15
	>=gnome-base/bonobo-1.0.9-r1
	>=gnome-base/gnome-libs-1.4.1.7
	=gnome-base/libglade-0*"


RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {

	local myconf

	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO

	doman ${S}/doc/gthumb.1
}
