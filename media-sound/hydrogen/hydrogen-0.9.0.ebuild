# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/hydrogen/hydrogen-0.9.0.ebuild,v 1.8 2005/04/05 23:28:35 jnc Exp $

IUSE="alsa jack ladspa"

inherit eutils kde-functions

need-qt 3

DESCRIPTION="Linux Drum Machine"
HOMEPAGE="http://hydrogen.sourceforge.net/"
SRC_URI="mirror://sourceforge/hydrogen/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86 ppc64"

DEPEND=">=media-libs/libsndfile-1.0.0
	alsa? ( media-libs/alsa-lib )
	media-libs/libsndfile
	>=media-libs/audiofile-0.2.3
	>=media-libs/flac-1
	jack? ( media-sound/jack-audio-connection-kit )
	ladspa? ( media-libs/liblrdf )
	>=x11-libs/qt-3"

src_compile() {
	need-autoconf 2.5
	econf $(use_enable jack jack-support) \
	      $(use_enable alsa alsa-seq) \
	      $(use_enable ladspa lrdf-support) \
	      || die "Failed configuring hydrogen!"
	emake || die "Failed making hydrogen!"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
