# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/extace/extace-1.8.11.ebuild,v 1.11 2004/12/29 02:59:28 ribosome Exp $

IUSE=""

DESCRIPTION="eXtace is an ESD audio visualization application"
HOMEPAGE="http://extace.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64"

DEPEND="media-sound/esound
	=sci-libs/fftw-2*"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS CREDITS ChangeLog NEWS README TODO
}
