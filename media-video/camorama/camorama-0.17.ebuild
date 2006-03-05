# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camorama/camorama-0.17.ebuild,v 1.4 2006/03/05 22:47:22 chainsaw Exp $

inherit gnome2 eutils

IUSE=""
DESCRIPTION="A GNOME 2 Webcam application featuring various image filters."
HOMEPAGE="http://camorama.fixedgear.org/"
SRC_URI="http://camorama.fixedgear.org/downloads/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
DEPEND=">=x11-libs/gtk+-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/gconf-2.0
	>=gnome-base/libglade-2.0
	>=sys-devel/gettext-0.11
	>=dev-util/intltool-0.20"

SCROLLKEEPER_UPDATE="0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc4.patch
}
