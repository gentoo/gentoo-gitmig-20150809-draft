# Copyright 2002, Gentoo Technologies Inc.
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-xmms/alsa-xmms-0.9.ebuild,v 1.2 2002/07/11 06:30:40 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Allows XMMS to output on any ALSA 0.9* device. It also supports surround 4.0 output with conversion"
SRC_URI="http://freesoftware.fsf.org/download/${PN}/${P}.tar.gz"
HOMEPAGE="http://freesoftware.fsf.org/download/alsa-xmms/"
SLOT="0"

DEPEND="media-sound/xmms
	>=media-libs/alsa-lib-0.9.0_rc1
	>=media-sound/alsa-driver-0.9.0_rc1
	x11-libs/gtk+"

src_install() {

	einstall \
		libdir=${D}/usr/lib/xmms/Output || die
}
