# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/uhinv/uhinv-0.4.ebuild,v 1.1 2004/12/22 17:12:43 pvdabeel Exp $

DESCRIPTION="Universal Hardware Inventory Tool, uhinv displays operating system and hardware info"
HOMEPAGE="http://developer.berlios.de/projects/uhinv/"
SRC_URI="http://download.berlios.de/uhinv/${P}.tar.gz"

KEYWORDS="x86 sparc mips hppa ppc amd64 arm"
SLOT="0"
LICENSE="GPL-2"

IUSE=""

src_install() {
	einstall || die
}
