# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/hydrogen/hydrogen-0.9.0.ebuild,v 1.1 2004/11/07 22:04:20 chriswhite Exp $

IUSE="alsa jack ladspa"

inherit eutils kde-functions

need-qt 3

DESCRIPTION="Linux Drum Machine"
HOMEPAGE="http://hydrogen.sourceforge.net/"
SRC_URI="mirror://sourceforge/hydrogen/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"


DEPEND=">=media-libs/libsndfile-1.0.0
	alsa? ( media-libs/alsa-lib )
	>=media-libs/audiofile-0.2.3
	>=media-libs/flac-1
	jack? ( media-sound/jack-audio-connection-kit )
	ladspa? ( media-libs/liblrdf )"

src_compile() {
	need-automake 2.5
	econf \
	$(use_enable jack jack-support) \
	$(use_enable alsa alsa-seq) \
	$(use_enable ladspa lrdf-support) \
	|| die "Failed configuring hydrogen!"
	emake || die "Failed making hydrogen!"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO
}
