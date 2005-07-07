# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/alsa-jack/alsa-jack-1.0.9.ebuild,v 1.3 2005/07/07 09:05:07 eradicator Exp $

inherit libtool

DESCRIPTION="JACK pcm plugin"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/plugins/alsa-plugins-${PV}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 -sparc ~x86"
IUSE=""

DEPEND="~media-libs/alsa-lib-${PV}
	media-sound/jack-audio-connection-kit"

S=${WORKDIR}/alsa-plugins-${PV}

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
