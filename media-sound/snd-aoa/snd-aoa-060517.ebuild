# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/snd-aoa/snd-aoa-060517.ebuild,v 1.1 2006/05/18 08:26:09 josejx Exp $

inherit linux-mod

DESCRIPTION="ALSA sound driver for late model Macs."
HOMEPAGE="http://johannes.sipsolutions.net/snd-aoa.git"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""

DEPEND=""
RDEPEND=""

BUILD_TARGETS="modules"
MODULE_NAMES="snd-aoa(sound:${S}:${S}/aoa/)
			  snd-aoa-fabric-layout(sound:${S}:${S}/aoa/fabrics/)
			  snd-aoa-codec-onyx(sound:${S}:${S}/aoa/codecs/onyx/)
			  snd-aoa-codec-tas(sound:${S}:${S}/aoa/codecs/tas/)
			  soundbus(sound:${S}:${S}/soundbus/)
			  i2sbus(sound:${S}:${S}/soundbus/i2sbus/)"
