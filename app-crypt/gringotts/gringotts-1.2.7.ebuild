# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gringotts/gringotts-1.2.7.ebuild,v 1.7 2004/10/05 11:46:56 pvdabeel Exp $

DESCRIPTION="Utility that allows you to jot down sensitive data"
HOMEPAGE="http://devel.pluto.linux.it/projects/Gringotts/"
SRC_URI="http://devel.pluto.linux.it/projects/Gringotts/current/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-libs/libgringotts-1.2.0
	dev-libs/popt
	>=x11-libs/gtk+-2.0.6-r1
	sys-apps/coreutils"

src_install() {
	einstall || die

	# The FAQ and README documents shouldn't be gzip'd, as they need to be
	# available in plain format when they are called from the `Help' menu.
	#
	# dodoc FAQ README
	dodoc AUTHORS BUGS ChangeLog TODO
}
