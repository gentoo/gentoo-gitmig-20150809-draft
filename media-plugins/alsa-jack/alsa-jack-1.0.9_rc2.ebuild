# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/alsa-jack/alsa-jack-1.0.9_rc2.ebuild,v 1.1 2005/03/31 03:41:10 eradicator Exp $

IUSE=""

inherit libtool

MY_PV=${PV/_rc/rc}
S=${WORKDIR}/alsa-plugins-${MY_PV}

DESCRIPTION="JACK pcm plugin"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/plugins/alsa-plugins-${MY_PV}.tar.bz2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
LICENSE="GPL-2 LGPL-2.1"

DEPEND="~media-libs/alsa-lib-${PV}
	media-sound/jack-audio-connection-kit"

src_compile() {
	econf

	cd ${S}/pcm/jack
	emake || die "make on jack plugin failed"
}

src_install() {
	cd ${S}/pcm/jack
	make DESTDIR="${D}" install || die "make install on jack plugin failed"
}
