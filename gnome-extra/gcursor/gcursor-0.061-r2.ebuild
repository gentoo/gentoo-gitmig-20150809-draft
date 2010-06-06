# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gcursor/gcursor-0.061-r2.ebuild,v 1.1 2010/06/06 09:33:53 ssuominen Exp $

EAPI=2
inherit eutils gnome2

DESCRIPTION="GTK+ based xcursor theme selector"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog TODO"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.6-xorg-x11.patch \
		"${FILESDIR}"/${P}-signal.patch
	gnome2_src_prepare
}
