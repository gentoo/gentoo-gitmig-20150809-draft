# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/daudio/daudio-0.3.ebuild,v 1.2 2004/06/24 23:56:46 agriffis Exp $

DESCRIPTION="Distributed audio on the local network"
HOMEPAGE="http://daudio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="virtual/glibc
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
