# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/wengophone/wengophone-1.0_pre20060106.ebuild,v 1.2 2006/01/13 12:26:19 genstef Exp $

inherit qt3 eutils

DESCRIPTION="Wengophone is a VoIP client featuring the SIP protcol"
HOMEPAGE="http://dev.openwengo.com"
SRC_URI="http://dev.gentoo.org/~genstef/files/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="media-libs/alsa-lib
	dev-libs/glib
	sys-libs/zlib
	$(qt_min_version 3.3.4)"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers
	dev-util/scons
	media-libs/speex"

src_compile() {
	scons softphone-runtime softphone || die "scons failed"
}

src_install() {
	scons prefix=${D}/usr softphone-install || die "scons softphone-install failed"
	sed -i "s:${D}::" ${D}/usr/bin/${PN}
	fperms 755 /usr/bin/wengophone

	doicon wengophone.png
	domenu wengophone.desktop
}
