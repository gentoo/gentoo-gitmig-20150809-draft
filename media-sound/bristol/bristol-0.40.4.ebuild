# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bristol/bristol-0.40.4.ebuild,v 1.1 2009/06/23 20:41:55 aballier Exp $

DESCRIPTION="Synthesizer keyboard emulation package: Moog, Hammond and others"
HOMEPAGE="http://sourceforge.net/projects/bristol"
SRC_URI="mirror://sourceforge/bristol/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa jack"
# osc : configure option but no code it seems...

RDEPEND="jack? ( >=media-sound/jack-audio-connection-kit-0.109.2 )
	alsa? ( >=media-libs/alsa-lib-1.0.0 )
	x11-libs/libX11"
# osc? ( >=media-libs/liblo-0.22 )
DEPEND="${RDEPEND}
	x11-proto/xproto
	dev-util/pkgconfig"

src_compile() {
	econf \
		$(use_enable alsa) \
		$(use_enable jack)
#		$(use_enable osc liblo)
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
