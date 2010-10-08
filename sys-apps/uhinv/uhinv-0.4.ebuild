# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/uhinv/uhinv-0.4.ebuild,v 1.4 2010/10/08 02:24:06 leio Exp $

DESCRIPTION="Universal Hardware Inventory Tool, uhinv displays operating system and hardware info"
HOMEPAGE="http://developer.berlios.de/projects/uhinv/"
SRC_URI="http://download.berlios.de/uhinv/${P}.tar.gz"

KEYWORDS="amd64 arm hppa ~mips ppc ppc64 sparc x86"
SLOT="0"
LICENSE="GPL-2"

IUSE=""

src_install() {
	einstall || die
}
