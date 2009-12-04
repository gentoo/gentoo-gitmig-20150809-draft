# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qsampler/qsampler-0.2.2.ebuild,v 1.1 2009/12/04 19:01:06 aballier Exp $

EAPI="1"
inherit qt4

DESCRIPTION="A graphical frontend to the LinuxSampler engine"
HOMEPAGE="http://www.linuxsampler.org"
SRC_URI="http://download.linuxsampler.org/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +libgig"

RDEPEND="x11-libs/qt-gui:4
	>=media-libs/liblscp-0.5.5
	libgig? ( >=media-libs/libgig-3.2.1 )
	>=media-sound/linuxsampler-0.5
	media-libs/alsa-lib"
DEPEND="${RDEPEND}"

src_compile() {
	econf $(use_enable debug) \
		$(use_enable libgig)
	eqmake4 qsampler.pro -o qsampler.mak
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TODO
	doman debian/${PN}.1
}
