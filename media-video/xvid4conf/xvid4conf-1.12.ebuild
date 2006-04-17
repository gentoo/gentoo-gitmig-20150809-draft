# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xvid4conf/xvid4conf-1.12.ebuild,v 1.12 2006/04/17 15:50:34 flameeyes Exp $

DESCRIPTION="GTK2-configuration dialog for xvid4"
HOMEPAGE="none"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.2.4"

src_install() {
	dodir /usr/{include,lib}
	einstall || die

	dodoc AUTHORS ChangeLog README
}
