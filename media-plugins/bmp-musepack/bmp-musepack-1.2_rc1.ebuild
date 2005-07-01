# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-musepack/bmp-musepack-1.2_rc1.ebuild,v 1.2 2005/07/01 09:52:42 dholm Exp $

MY_P=${P/_rc/-RC}
S=${WORKDIR}/${MY_P}

IUSE=""

DESCRIPTION="Beep Media Player plugin to play audio files encoded with Andree Buschmann's encoder Musepack (mpc, mp+, mpp)"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://musepack.origean.net/files/linux/plugins/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="media-sound/beep-media-player
	>=media-libs/libmpcdec-1.2
	>=media-libs/taglib-1.3.1-r2"

src_compile() {
	ebegin "Rebuilding configure script"
	WANT_AUTOMAKE=1.7 autoreconf -f -i &> /dev/null
	eend $?
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
}
