# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/acme/acme-2.4.2.ebuild,v 1.2 2004/01/14 11:55:31 obz Exp $

inherit gnome2

DESCRIPTION="GNOME tool to make use of the multimedia buttons on laptops and internet keyboards"
HOMEPAGE="http://www.hadess.net/misc-code.php3"

IUSE=""
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 ~ppc ~alpha ~sparc ~hppa ~amd64"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=x11-libs/libwnck-2.2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README"
