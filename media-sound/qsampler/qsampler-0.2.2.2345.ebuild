# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qsampler/qsampler-0.2.2.2345.ebuild,v 1.1 2012/05/30 13:43:47 yngwin Exp $

EAPI=4
inherit eutils qt4-r2

DESCRIPTION="A graphical frontend to the LinuxSampler engine"
HOMEPAGE="http://qsampler.sourceforge.net"
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +libgig"

DEPEND="media-libs/alsa-lib
	>=media-libs/liblscp-0.5.5
	x11-libs/libX11
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	libgig? ( >=media-libs/libgig-3.2.1 )"
RDEPEND="${DEPEND}
	>=media-sound/linuxsampler-0.5"

src_configure() {
	econf $(use_enable debug) \
		$(use_enable libgig)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README TODO
	doman debian/${PN}.1
}
