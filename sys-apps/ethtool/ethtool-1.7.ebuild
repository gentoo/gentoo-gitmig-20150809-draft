# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ethtool/ethtool-1.7.ebuild,v 1.8 2004/03/10 21:52:49 agriffis Exp $

DESCRIPTION="Utility for examining and tuning your ethernet-based network interface"

HOMEPAGE="http://sourceforge.net/projects/gkernel/"

SRC_URI="mirror://sourceforge/gkernel/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="x86 amd64 alpha sparc ppc hppa ia64"

IUSE=""

src_install () {
	einstall || die
	dodoc NEWS README INSTALL
}
