# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gringotts/gringotts-1.2.7.ebuild,v 1.1 2003/04/28 23:24:14 liquidx Exp $

DESCRIPTION="Utility that allows you to jot down sensitive data"
SRC_URI="http://devel.pluto.linux.it/projects/Gringotts/current/${P}.tar.bz2"
HOMEPAGE="http://devel.pluto.linux.it/projects/Gringotts/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-libs/libgringotts-1.2.0
	dev-libs/popt
	>=x11-libs/gtk+-2.0.6-r1
	sys-apps/textutils"

src_install() {
	einstall

	# The FAQ and README documents shouldn't be gzip'd, as they need to be
	# available in plain format when they are called from the `Help' menu.
	#
	# dodoc FAQ README
	dodoc AUTHORS BUGS ChangeLog COPYING TODO
}
