# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-musepack/xmms-musepack-1.1.ebuild,v 1.2 2004/12/05 16:58:07 chainsaw Exp $

IUSE=""

DESCRIPTION="XMMS plugin to play audio files encoded with Andree Buschmann's encoder Musepack (mpc, mp+, mpp)"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://www.saunalahti.fi/grimmel/musepack.net/linux/plugins/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="media-sound/xmms
	>=media-libs/libmusepack-1.0.3"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README
}
