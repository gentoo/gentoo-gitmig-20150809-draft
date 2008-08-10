# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/metamonitor/metamonitor-0.4.5.ebuild,v 1.3 2008/08/10 15:12:30 jokey Exp $

inherit kde

DESCRIPTION="Log monitoring tool for KDE."
SRC_URI="mirror://sourceforge/metamonitor/${P}.tar.bz2"
HOMEPAGE="http://metamonitor.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

need-kde 3.3

src_unpack() {
	kde_src_unpack

	# We need patch to build w/ gcc 4.3.1, see bug #227253
	epatch "${FILESDIR}"/${P}-gcc43.patch
}
