# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/rte/rte-0.4.ebuild,v 1.2 2002/07/11 06:30:39 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Real Time Encoder"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/zapping/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net/"

DEPEND="esd? media-sound/esound
	alsa? media-libs/alsa-lib"
SLOT="0"

src_install () {

	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
