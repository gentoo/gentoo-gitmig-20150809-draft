# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/kvdr/kvdr-0.64-r3.ebuild,v 1.1 2009/01/10 12:37:46 beandog Exp $

inherit kde eutils

DESCRIPTION="A KDE GUI for VDR (Video Disk Recorder)."
HOMEPAGE="http://www.s.netic.de/gfiala/"
#SRC_URI="http://www.s.netic.de/gfiala/${P}.tgz"
SRC_URI="mirror://gentoo/${P}-gentoo.tar.gz
	http://dev.gentoo.org/~zzam/distfiles/${P}-gentoo.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-tv/xawtv-3.86
	media-tv/linuxtv-dvb-headers
	>=media-video/vdr-1.2.0
	x11-libs/libXxf86dga"

need-kde 3

S="${WORKDIR}"/${P}-gentoo

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/kvdr-0.64-pointer-casting.patch"
	epatch "${FILESDIR}/kvdr-0.64-unsigned-int-casting.patch"
	epatch "${FILESDIR}/kvdr-0.64-remove-ansi-cflag.patch"
	epatch "${FILESDIR}/kvdr-0.64-desktop-file.patch"
}
