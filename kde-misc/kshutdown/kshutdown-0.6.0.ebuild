# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kshutdown/kshutdown-0.6.0.ebuild,v 1.4 2005/08/23 22:19:06 greg_g Exp $

inherit kde eutils

DESCRIPTION="A shutdown manager for KDE"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://kshutdown.sourceforge.net"
LICENSE="GPL-2"

IUSE=""
KEYWORDS="~ppc x86"
SLOT="0"

need-kde 3.3

src_unpack() {
	kde_src_unpack

	# Patch sent upstream, will be in 0.6.1.
	epatch "${FILESDIR}/${P}-makefile-fix.patch"
	make -f admin/Makefile.common
}
