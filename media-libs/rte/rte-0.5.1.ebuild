# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/rte/rte-0.5.1.ebuild,v 1.9 2005/08/29 23:28:04 vanquirius Exp $

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
