# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/acme/acme-2.0.ebuild,v 1.2 2003/02/13 12:15:30 vapier Exp $

inherit gnome2

IUSE="gnome"

S=${WORKDIR}/${P}
DESCRIPTION="GNOME tool to make use of the multimedia buttons present on most laptops and internet keyboards."
#SRC_URI="http://www.hadess.net/files/software/acme/${P}.tar.gz"
HOMEPAGE="http://www.hadess.net/misc-code.php3"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

DEPEND=">=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	x11-libs/libwnck"

RDEPEND="${DEPEND}
	>=gnome-base/gconf-1.2
	>=dev-util/intltool-0.20
	sys-devel/gettext
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README"
