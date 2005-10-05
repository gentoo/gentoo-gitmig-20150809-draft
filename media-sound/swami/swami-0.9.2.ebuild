# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/swami/swami-0.9.2.ebuild,v 1.2 2005/10/05 16:27:34 matsuu Exp $

inherit eutils

DESCRIPTION="A GPL sound font editor"
HOMEPAGE="http://swami.sourceforge.net/"
SRC_URI="mirror://sourceforge/swami/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="audiofile debug nls"

DEPEND="media-libs/alsa-lib
	=x11-libs/gtk+-1.2*
	>=media-sound/fluidsynth-1.0.4
	audiofile? ( >=media-libs/audiofile-0.2.0 )
	>=media-libs/libsndfile-1.0.0
	dev-util/pkgconfig"

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable debug) \
		$(use_enable audiofile) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README
}
