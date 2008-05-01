# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bristol/bristol-0.20.5.ebuild,v 1.1 2008/05/01 20:36:53 aballier Exp $

inherit autotools eutils

DESCRIPTION="Synthesizer keyboard emulation package: Moog, Hammond and others"
HOMEPAGE="http://sourceforge.net/projects/bristol"
SRC_URI="mirror://sourceforge/bristol/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa jack"

RDEPEND="jack? ( >=media-sound/jack-audio-connection-kit-0.99.0 )
	alsa? ( >=media-libs/alsa-lib-1.0.0 )
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-cflags.patch"
	epatch "${FILESDIR}/${P}-asneeded.patch"
	eautoreconf
}

src_compile() {
	econf \
		$(use_enable alsa) \
		$(use_enable jack)
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
