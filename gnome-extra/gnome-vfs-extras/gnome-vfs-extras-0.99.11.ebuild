# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-vfs-extras/gnome-vfs-extras-0.99.11.ebuild,v 1.2 2003/09/08 05:19:19 msterret Exp $

inherit gnome2

IUSE=""
DESCRIPTION="Extra GNOME Virtual File System modules, currently only contains a smb share browser module."
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

RDEPEND=">=gnome-base/gnome-vfs-2.1.5
	net-fs/samba"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS  README"
