# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ethtool/ethtool-2.ebuild,v 1.1 2004/09/30 03:20:43 vapier Exp $

DESCRIPTION="Utility for examining and tuning ethernet-based network interfaces"
HOMEPAGE="http://sourceforge.net/projects/gkernel/"
SRC_URI="mirror://sourceforge/gkernel/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
