# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ethtool/ethtool-1.7.ebuild,v 1.6 2003/08/03 15:31:52 gmsoft Exp $

DESCRIPTION="Utility for examining and tuning your ethernet-based network interface"

HOMEPAGE="http://sourceforge.net/projects/gkernel/"

SRC_URI="mirror://sourceforge/gkernel/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="x86 amd64 alpha sparc  ppc hppa"

IUSE=""

src_install () {
	einstall || die
	dodoc NEWS README INSTALL
}
