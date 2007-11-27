# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvbsnoop/dvbsnoop-1.4.00.ebuild,v 1.5 2007/11/27 12:24:18 zzam Exp $

DESCRIPTION="DVB/MPEG stream analyzer program"
SRC_URI="mirror://sourceforge/dvbsnoop/${P}.tar.gz"
HOMEPAGE="http://dvbsnoop.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
DEPEND="media-tv/linuxtv-dvb-headers"

RDEPEND=""
SLOT="0"
IUSE=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README
}
