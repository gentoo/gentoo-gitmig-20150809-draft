# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/rte/rte-0.4.ebuild,v 1.13 2004/07/14 20:25:50 agriffis Exp $

IUSE="esd alsa"

DESCRIPTION="Real Time Encoder"
SRC_URI="mirror://sourceforge/zapping/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net/"

DEPEND="esd? ( media-sound/esound )
	alsa? ( media-libs/alsa-lib )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -sparc"

src_compile() {

	econf || die
	make || die
}

src_install () {

	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
