# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/alsa-jack/alsa-jack-1.0.8.ebuild,v 1.6 2006/04/24 10:01:29 flameeyes Exp $

IUSE=""

inherit libtool

MY_PV=${PV/_rc/rc}
S=${WORKDIR}/alsa-lib-${MY_PV}

DESCRIPTION="JACK pcm plugin. Allows native ALSA applications to connect to the jackd. Works transparantly for both capture and playback."
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/lib/alsa-lib-${MY_PV}.tar.bz2"

SLOT="0"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86"
LICENSE="GPL-2 LGPL-2.1"

DEPEND="~media-libs/alsa-lib-${PV}
	media-sound/jack-audio-connection-kit
	!media-plugins/alsa-plugins"

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
