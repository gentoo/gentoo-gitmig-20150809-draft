# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-vfs-extras/gnome-vfs-extras-0.99.11.ebuild,v 1.12 2004/07/14 15:54:16 agriffis Exp $

inherit gnome2

DESCRIPTION="Extra GNOME Virtual File System modules, currently only contains a smb share browser module."
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc amd64 hppa alpha ia64 mips"
IUSE=""

RDEPEND=">=gnome-base/gnome-vfs-2.1.5
	net-fs/samba"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"
