# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/wengophone/wengophone-1.0_pre20060408.ebuild,v 1.1 2006/04/08 22:45:44 genstef Exp $

inherit qt3 eutils

DESCRIPTION="Wengophone is a VoIP client featuring the SIP protcol"
HOMEPAGE="http://dev.openwengo.com"
SRC_URI="http://dev.gentoo.org/~genstef/files/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="oss"

RDEPEND="!oss? ( media-libs/alsa-lib )
	dev-libs/glib
	sys-libs/zlib
	$(qt_min_version 3.3.4)"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers
	dev-util/scons
	media-libs/speex"

src_compile() {
	if use oss; then
		sed -e 's|PA_USE_ALSA|PA_USE_OSS|g' \
		    -e 's|sources_alsa|sources_oss|g' \
			-e 's|pa_env.WengoLibAdd("asound")||g' \
			-i libs/portaudio/SConscript \
			|| die "Failed to patch SConscript to build OSS support"
	fi
	epatch ${FILESDIR}/debian.patch

	scons mode=release-symbols \
		enable-shared-portaudio=no enable-shared-webcam=no \
		enable-shared-wengocurl=no enable-shared-phapi=no \
		softphone-runtime softphone || die "scons failed"
}

src_install() {
	#scons prefix=${D}/usr softphone-install || die "scons softphone-install failed"
	#sed -i "s:${D}::" ${D}/usr/bin/${PN}
	#fperms 755 /usr/bin/wengophone
	cd build-wengo/linux2-release-symbols/softphone
	dobin runtime/wengophone
	insinto /usr/share/wengophone
	doins -r runtime/{icons,sounds,emoticons}
	insinto /usr/share/wengophone/lang
	doins -r gui/lang/*.qm

	cd ${S}
	doicon wengophone.png
	domenu wengophone.desktop
}
