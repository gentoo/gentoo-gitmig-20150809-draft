# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gok/gok-0.10.0.ebuild,v 1.1 2004/03/23 22:44:47 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="Gnome Onscreen Keyboard"
HOMEPAGE="http://www.gok.ca/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="~x86 -sparc ~hppa ~alpha ~ia64 ~ppc ~amd64"

IUSE=""

RDEPEND=">=x11-libs/gtk+-2.3.1
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonobo-2.5.1
	>=gnome-base/gconf-2
	>=dev-libs/atk-1.3
	gnome-base/gail
	media-sound/esound
	>=x11-libs/libwnck-1
	>=gnome-extra/at-spi-1.3.4
	virtual/x11"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.27.3
	dev-util/pkgconfig
	app-text/scrollkeeper"

DOCS="AUTHORS ChangeLog COPYING NEWS README"

src_unpack()
{
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:\$pkgdatadir:${ROOT}/usr/share/${PN}:" \
		gok-with-references.schemas.m4
}
