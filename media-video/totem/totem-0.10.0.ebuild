# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/totem/totem-0.10.0.ebuild,v 1.2 2002/09/15 07:57:17 seemant Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Totem is simple movie player for the Gnome2 desktop based on xine."
SRC_URI="http://www.hadess.net/files/software/totem/${P}.tar.gz"
HOMEPAGE="http://www.hadess.net/totem.php3"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"

RDEPEND=">=dev-libs/glib-2.0.6
	>=x11-libs/gtk+-2.0.6
	>=gnome-base/libgnome-2.0.2
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/gnome-vfs-2.0.1
	>=gnome-base/libglade-2.0.0
	>=media-libs/xine-lib-0.9.13
	dvd? ( >=media-video/xine-dvdnav-0.9.13 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.17
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING*  README* INSTALL NEWS"

