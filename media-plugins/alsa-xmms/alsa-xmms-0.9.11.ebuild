# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/alsa-xmms/alsa-xmms-0.9.11.ebuild,v 1.1 2003/05/13 23:15:15 agenkin Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Allows XMMS to output on any ALSA 0.9* device.  Supports surround 4.0 output with conversion"
HOMEPAGE="http://savannah.gnu.org/download/alsa-xmms/"
SRC_URI="http://savannah.gnu.org/download/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="media-sound/xmms
	>=media-libs/alsa-lib-0.9.0_rc2
	>=media-sound/alsa-driver-0.9.0_rc2"

src_install() {
	einstall \
		libdir=${D}/usr/lib/xmms/Output || die

	dodoc AUTHORS README NEWS COPYING ChangeLog
}
