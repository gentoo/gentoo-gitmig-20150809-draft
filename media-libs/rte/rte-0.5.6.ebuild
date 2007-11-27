# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/rte/rte-0.5.6.ebuild,v 1.6 2007/11/27 18:57:00 zzam Exp $

inherit eutils

IUSE="esd alsa"

DESCRIPTION="Real Time Encoder"
SRC_URI="mirror://sourceforge/zapping/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net/"

DEPEND="esd? ( media-sound/esound )
	alsa? ( media-libs/alsa-lib )"

SLOT="0"
LICENSE="GPL-2"
# This package contains x86 assembly.
# It could potentially be made to work with other packages, as it uses a
# modified ffmpeg as one of the backends.
# ~amd64 may work, but is not tested at this time.
KEYWORDS="-* x86"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-config.patch
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
