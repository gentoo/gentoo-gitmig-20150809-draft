# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-1.3.ebuild,v 1.7 2004/11/24 23:35:59 motaboy Exp $

inherit kde


DESCRIPTION="MSN Messenger clone for KDE"
HOMEPAGE="http://kmess.sourceforge.net"
SRC_URI="mirror://sourceforge/kmess/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc"
IUSE=""

DEPEND="kde-base/kdenetwork"
need-kde 3

src_unpack() {
	kde_src_unpack

	epatch ${FILESDIR}/${P}-compilation-fix.patch
}