# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/swfdec-gnome/swfdec-gnome-0.5.5.ebuild,v 1.1 2007/12/22 10:27:18 pclouds Exp $

inherit gnome2

DESCRIPTION="flash player and thumbnailer for GNOME"
HOMEPAGE="http://swfdec.freedesktop.org/wiki/"
SRC_URI="http://swfdec.freedesktop.org/download/swfdec-gnome/0.5/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12.0
		gnome-base/gconf
		=media-libs/swfdec-${PV}*"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	sys-devel/gettext"
