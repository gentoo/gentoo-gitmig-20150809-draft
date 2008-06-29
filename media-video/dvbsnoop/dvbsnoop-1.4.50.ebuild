# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvbsnoop/dvbsnoop-1.4.50.ebuild,v 1.3 2008/06/29 10:12:51 zzam Exp $

DESCRIPTION="DVB/MPEG stream analyzer program"
SRC_URI="mirror://sourceforge/dvbsnoop/${P}.tar.gz"
HOMEPAGE="http://dvbsnoop.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"
DEPEND="media-tv/linuxtv-dvb-headers"

RDEPEND=""
SLOT="0"
IUSE=""

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog README
}
