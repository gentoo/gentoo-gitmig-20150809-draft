# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/snd-aoa/snd-aoa-060608.ebuild,v 1.1 2006/06/08 23:53:28 josejx Exp $

inherit linux-mod

DESCRIPTION="ALSA sound driver for late model Macs."
HOMEPAGE="http://johannes.sipsolutions.net/snd-aoa.git"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~ppc64"
IUSE=""

DEPEND=""
RDEPEND=""

BUILD_TARGETS="modules"
MODULE_NAMES="snd-aoa(sound:${S}:${S}/core/)
			  snd-aoa-fabric-layout(sound:${S}:${S}/fabrics/)
			  snd-aoa-codec-onyx(sound:${S}:${S}/codecs/)
			  snd-aoa-codec-tas(sound:${S}:${S}/codecs/)
			  snd-aoa-codec-toonie(sound:${S}:${S}/codecs/)
			  snd-aoa-soundbus(sound:${S}:${S}/soundbus/)
			  snd-aoa-i2sbus(sound:${S}:${S}/soundbus/i2sbus/)"
BUILD_PARAMS="KDIR=/usr/src/linux"

