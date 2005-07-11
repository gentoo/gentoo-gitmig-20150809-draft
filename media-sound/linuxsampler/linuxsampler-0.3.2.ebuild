# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/linuxsampler/linuxsampler-0.3.2.ebuild,v 1.2 2005/07/11 16:56:14 fvdpol Exp $

inherit eutils

DESCRIPTION="LinuxSampler is a software audio sampler engine with professional grade features."
HOMEPAGE="http://www.linuxsampler.org/"
SRC_URI="http://download.linuxsampler.org/packages/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE="jack"
RDEPEND="
	>=media-libs/liblscp-0.2.9
	>=media-libs/libgig-2.0.1
	media-libs/alsa-lib
	jack? ( media-sound/jack-audio-connection-kit )"

DEPEND="${RDEPEND}"

src_compile() {
	econf || die "./configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog INSTALL README
}
