# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/totem/totem-0.13.1.ebuild,v 1.3 2003/02/13 13:35:17 vapier Exp $

inherit gnome2

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="Totem is simple movie player for the Gnome2 desktop based on xine."
SRC_URI="http://www.hadess.net/files/software/totem/${P}.tar.gz"
HOMEPAGE="http://www.hadess.net/totem.php3"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libglade-2
	|| ( =media-libs/xine-lib-1_alpha2 =media-libs/xine-lib-1_alpha1 =media-libs/xine-lib-0.9.14 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.17
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING*  README* INSTALL NEWS"
