# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ethtool/ethtool-3_p20060531.ebuild,v 1.1 2006/05/31 20:16:21 robbat2 Exp $

DESCRIPTION="Utility for examining and tuning ethernet-based network interfaces"
HOMEPAGE="http://sourceforge.net/projects/gkernel/"
SRC_URI="mirror://gentoo/${P/_p/-}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~mips"
IUSE=""
S="${WORKDIR}/${P/_p/-}"

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog* NEWS README
}
