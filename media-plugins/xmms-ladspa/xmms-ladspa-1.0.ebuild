# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-ladspa/xmms-ladspa-1.0.ebuild,v 1.4 2006/02/21 00:07:18 metalgod Exp $

IUSE=""

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="XMMS LADSPA Plugin"
HOMEPAGE="http://www.ecs.soton.ac.uk/~njl98r/code/audio/"
SRC_URI="http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"
SLOT="0"
DEPEND="media-libs/ladspa-sdk
	media-plugins/swh-plugins
	media-sound/xmms"

src_install() {
	exeinto $(xmms-config --effect-plugin-dir)
	doexe ${S}/ladspa.so || die
	dodoc PLUGINS README || die
}
