# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-musepack/bmp-musepack-1.1.2.ebuild,v 1.2 2005/02/06 02:01:16 luckyduck Exp $

IUSE=""

DESCRIPTION="Beep Media Player plugin to play audio files encoded with Andree Buschmann's encoder Musepack (mpc, mp+, mpp)"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://files.musepack.net/linux/plugins/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="media-sound/beep-media-player
	>=media-libs/libmusepack-1.1"

src_compile() {
	einfo "You can probably unmerge libmusepack-1.0.3 after this compile is complete."
	ebegin "Rebuilding configure script"
	WANT_AUTOMAKE=1.7 autoreconf -f -i &> /dev/null
	eend $?
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
}
