# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-file/libopensync-plugin-file-0.19.ebuild,v 1.1 2006/10/23 18:15:43 peper Exp $

DESCRIPTION="OpenSync File Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

DEPEND=">=app-pda/libopensync-0.19"
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog COPYING NEWS README
}
