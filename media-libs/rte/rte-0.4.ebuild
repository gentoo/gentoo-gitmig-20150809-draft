# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/rte/rte-0.4.ebuild,v 1.4 2002/08/14 13:08:10 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Real Time Encoder"
SRC_URI="mirror://sourceforge/zapping/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net/"

DEPEND="esd? ( media-sound/esound )
	alsa? ( media-libs/alsa-lib )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_install () {

	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
