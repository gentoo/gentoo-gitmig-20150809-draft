# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gcursor/gcursor-0.061-r1.ebuild,v 1.3 2007/02/12 18:40:46 drac Exp $

inherit gnome2 eutils

DESCRIPTION="GTK+ based xcursor theme selector"
HOMEPAGE="http://download.qballcow.nl/programs/gcursor"
SRC_URI="http://download.qballcow.nl/programs/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~ia64"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog TODO"

src_unpack() {
	unpack ${A}
	# Use xorg-x11 cursors path, bug 83450
	epatch ${FILESDIR}/gcursor-0.6-xorg-x11.patch
}
