# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/daudio/daudio-0.3.ebuild,v 1.5 2004/07/19 20:18:18 eradicator Exp $

DESCRIPTION="Distributed audio on the local network"
HOMEPAGE="http://daudio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#-sparc: 0.3: static audio on local daemon.  No audio when client connects to amd64 daemon
KEYWORDS="x86 ~amd64 -sparc"

IUSE=""
DEPEND="virtual/libc
	>=media-libs/libmad-0.15.0b-r1"

src_compile() {
	emake -C client || die "emake failed"
	emake -C server || die "emake failed"
	emake -C streamer || die "emake failed"
}

src_install() {
	dobin client/daudioc server/daudiod streamer/dstreamer
	exeinto /etc/init.d
	newexe ${FILESDIR}/daudio.rc daudio
	dodoc doc/*
}
