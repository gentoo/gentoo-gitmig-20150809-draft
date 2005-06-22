# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvbsnoop/dvbsnoop-1.3.77.ebuild,v 1.1 2005/06/22 21:10:55 zzam Exp $

DESCRIPTION="DVB/MPEG stream analyzer program"
SRC_URI="mirror://sourceforge/dvbsnoop/${P}.tar.gz"
HOMEPAGE="http://dvbsnoop.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~x86"
DEPEND="=media-tv/linuxtv-dvb-headers-3*"
RDEPEND=""
SLOT="0"
IUSE=""

src_compile() {
	econf \
		CPPFLAGS=-I/usr/include/dvb || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING README
}
