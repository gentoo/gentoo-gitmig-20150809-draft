# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-device-manager/gnome-device-manager-0.2.ebuild,v 1.1 2008/01/23 06:33:29 compnerd Exp $

inherit gnome2

DESCRIPTION="GNOME Device Manager"
HOMEPAGE="http://hal.freedesktop.org/"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6
		 >=gnome-base/libgnome-2.14
		 >=gnome-base/libgnomeui-2.14
		 >=sys-apps/hal-0.5.10"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		  app-text/scrollkeeper
		>=dev-util/intltool-0.35
		>=dev-util/pkgconfig-0.19"
