# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/rovclock/rovclock-0.6e.ebuild,v 1.1 2006/01/13 20:51:34 genstef Exp $

DESCRIPTION="Overclocking utility for ATI Radeon cards"
HOMEPAGE="http://www.hasw.net/linux/"
SRC_URI="http://www.hasw.net/linux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	dosbin rovclock
	dodoc ChangeLog README
}
