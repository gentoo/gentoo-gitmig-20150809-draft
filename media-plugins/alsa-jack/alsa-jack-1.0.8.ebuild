# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/alsa-jack/alsa-jack-1.0.8.ebuild,v 1.3 2005/03/20 17:40:30 pylon Exp $

IUSE=""

inherit libtool

MY_PV=${PV/_rc/rc}
S=${WORKDIR}/alsa-lib-${MY_PV}

DESCRIPTION="JACK pcm plugin"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/lib/alsa-lib-${MY_PV}.tar.bz2"

SLOT="0"
KEYWORDS="~alpha amd64 ppc ~ppc64 sparc x86"
LICENSE="GPL-2 LGPL-2.1"

DEPEND="~media-libs/alsa-lib-${PV}
	media-sound/jack-audio-connection-kit"

src_compile() {
	elibtoolize
	econf --enable-jack || die "./configure failed"

	cd ${S}/src/pcm/ext
	make jack || die "make on jack plugin failed"
}

src_install() {
	cd ${S}/src/pcm/ext
	make DESTDIR="${D}" install-jack || die "make install on jack plugin failed"
}
