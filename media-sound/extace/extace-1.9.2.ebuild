# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/extace/extace-1.9.2.ebuild,v 1.5 2006/09/11 03:44:37 metalgod Exp $

DESCRIPTION="eXtace is an ESD audio visualization application"
HOMEPAGE="http://extace.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="media-sound/esound
	=sci-libs/fftw-2*
	=x11-libs/gtk+-1.2*
	media-libs/imlib"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS CREDITS ChangeLog NEWS README TODO
}
