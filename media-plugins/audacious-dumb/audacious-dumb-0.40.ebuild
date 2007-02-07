# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/audacious-dumb/audacious-dumb-0.40.ebuild,v 1.1 2007/02/07 23:30:13 joker Exp $

DESCRIPTION="Audacious Plug-in for accurate, high-quality IT/XM/S3M/MOD playback"
HOMEPAGE="http://www.netswarm.net/"
SRC_URI="http://www.netswarm.net/misc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Plugin will only work with 1.3.0_alpha4 or later due to API changes
DEPEND=">=media-sound/audacious-1.3.0_alpha4
	>=media-libs/dumb-0.9.3"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog TODO README README-dumb-bmp README-dumb-xmms
}
