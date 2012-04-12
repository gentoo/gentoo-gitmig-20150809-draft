# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gnome-disk-utility/gnome-disk-utility-3.4.0.ebuild,v 1.1 2012/04/12 09:24:30 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Disk Utility for GNOME using udisks"
HOMEPAGE="http://git.gnome.org/browse/gnome-disk-utility"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="fat"

CDEPEND="
	>=dev-libs/glib-2.31:2
	>=sys-fs/udisks-1.90:2
	>=x11-libs/gtk+-3.3.11:3
"
RDEPEND="${CDEPEND}
	fat? ( sys-fs/dosfstools )"
DEPEND="${CDEPEND}
	>=dev-util/intltool-0.50
	>=dev-util/pkgconfig-0.9
"
