# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-vfs-sftp/gnome-vfs-sftp-0.1.2.ebuild,v 1.5 2004/06/24 22:06:41 agriffis Exp $

inherit gnome2

IUSE=""
DESCRIPTION="GNOME secure FTP virtual folder module"
HOMEPAGE="http://www.math.uwaterloo.ca/~bghovinen/gnome"
SRC_URI="http://www.math.uwaterloo.ca/~bghovinen/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"

RDEPEND=">=gnome-base/gnome-vfs-2
	net-misc/openssh"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
