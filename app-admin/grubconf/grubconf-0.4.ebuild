# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/grubconf/grubconf-0.4.ebuild,v 1.2 2003/04/23 14:19:57 vapier Exp $

inherit gnome2

DESCRIPTION="Gnome2 based GRUB configuration editor"
HOMEPAGE="http://grubconf.sf.net/"
SRC_URI="mirror://sourceforge/grubconf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=app-text/scrollkeeper-0.3.11
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gconf-1.2"

DEPEND="${RDEPEND}
	sys-apps/grub
	>=dev-util/pkgconfig-0.12.0"
