# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-ladspa/xmms-ladspa-0.6.ebuild,v 1.1 2002/11/07 21:49:03 seemant Exp $


MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_PN}
DESCRIPTION="XMMS LADSPA Plugin"
HOMEPAGE="http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/"
SRC_URI="http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="media-sound/alsa-driver
	media-plugins/swh-plugins
	media-sound/xmms"

src_compile() {
	emake || die
}

src_install() {
	insinto /usr/lib/xmms/Effect
	doins ${S}/ladspa.so
	dodoc COPYING PLUGINS README || die
}
