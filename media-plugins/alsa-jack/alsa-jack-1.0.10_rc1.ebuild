# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/alsa-jack/alsa-jack-1.0.10_rc1.ebuild,v 1.1 2005/08/25 00:09:22 flameeyes Exp $

inherit libtool

MY_PV="${PV/_rc/rc}"

DESCRIPTION="JACK pcm plugin"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/plugins/alsa-plugins-${MY_PV}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ppc64 -sparc x86"
IUSE=""

DEPEND="~media-libs/alsa-lib-${PV}
	media-sound/jack-audio-connection-kit"

S=${WORKDIR}/alsa-plugins-${MY_PV}

src_compile() {
	econf || die "configure failed"

	cd ${S}/pcm/jack
	emake || die "make on jack plugin failed"
}

src_install() {
	cd ${S}/pcm/jack
	make DESTDIR="${D}" install || die "make install on jack plugin failed"

	dodoc README
}
