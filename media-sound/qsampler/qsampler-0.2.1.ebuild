# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qsampler/qsampler-0.2.1.ebuild,v 1.1 2008/01/12 10:49:18 aballier Exp $

EAPI="1"

inherit qt4

DESCRIPTION="QSampler is a graphical frontend to the LinuxSampler engine."
HOMEPAGE="http://www.linuxsampler.org"
SRC_URI="http://download.linuxsampler.org/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +libgig"

RDEPEND="$(qt4_min_version 4.1)
	>=media-libs/liblscp-0.5.5
	libgig? ( >=media-libs/libgig-3.2.1 )
	>=media-sound/linuxsampler-0.5
	media-libs/alsa-lib"
DEPEND="${RDEPEND}"

src_compile() {
	econf $(use_enable debug) \
		$(use_enable libgig)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TODO
	doman debian/${PN}.1
}
