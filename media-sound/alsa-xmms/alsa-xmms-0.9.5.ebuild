# Copyright 2002, Gentoo Technologies Inc.
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-xmms/alsa-xmms-0.9.5.ebuild,v 1.1 2002/09/23 04:29:49 agenkin Exp $

DESCRIPTION="Allows XMMS to output on any ALSA 0.9* device.  Supports surround 4.0 output with conversion"
HOMEPAGE="http://savannah.gnu.org/download/alsa-xmms/"
LICENSE="GPL-2"

DEPEND="media-sound/xmms
	>=media-libs/alsa-lib-0.9.0_rc2
	>=media-sound/alsa-driver-0.9.0_rc2
	x11-libs/gtk+"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86"

SRC_URI="http://savannah.gnu.org/download/${PN}/${P}.tar.gz"
S=${WORKDIR}/${P}


src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}


src_install() {
	einstall \
		libdir=${D}/usr/lib/xmms/Output || die

	dodoc AUTHORS README NEWS COPYING ChangeLog
}
