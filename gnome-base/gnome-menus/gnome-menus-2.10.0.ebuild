# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-menus/gnome-menus-2.10.0.ebuild,v 1.5 2005/03/23 10:02:19 gmsoft Exp $

inherit gnome2

DESCRIPTION="The GNOME menu system, implementing the F.D.O cross-desktop spec"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~hppa"
IUSE=""

RDEPEND=">=dev-libs/glib-2.5.6
	>=gnome-base/gnome-vfs-2.8.2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.31"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

