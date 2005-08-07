# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/glabels/glabels-2.0.3.ebuild,v 1.2 2005/08/07 13:45:18 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="Program for creating labels and business cards"
HOMEPAGE="http://glabels.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="static"

RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.0.5
	>=gnome-base/libgnome-2.0.1
	>=gnome-base/libgnomeui-2.0.1
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=dev-libs/libxml2-2.4.23
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libgnomecanvas-2.0.1
	>=gnome-base/libglade-2.0.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/scrollkeeper
	>=dev-util/intltool-0.21"

DOCS="AUTHORS ChangeLog NEWS README TODO"


pkg_setup() {
	G2CONF="--disable-update-mimedb --disable-update-desktopdb \
		$(use_enable static)"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Avoid sandbox violation. See bug #60545.
	epatch ${FILESDIR}/${P}-update_dbs_switch.patch

	aclocal || die "aclocal failed"
	autoconf || die "autoconf failed"
	automake || die "automake failed"
	libtoolize --copy --force
}
