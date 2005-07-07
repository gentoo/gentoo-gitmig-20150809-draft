# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/hydrogen/hydrogen-0.9.1.ebuild,v 1.4 2005/07/07 04:46:09 caleb Exp $

inherit eutils kde-functions

need-qt 3

DESCRIPTION="Linux Drum Machine"
HOMEPAGE="http://hydrogen.sourceforge.net/"
SRC_URI="mirror://sourceforge/hydrogen/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~ppc64"
IUSE="alsa jack ladspa"

DEPEND=">=media-libs/libsndfile-1.0.0
	>=media-libs/audiofile-0.2.3
	>=media-libs/flac-1
	=x11-libs/qt-3*
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	ladspa? ( media-libs/liblrdf )"

src_unpack() {
	unpack ${A}
	cd ${S}
	if use ppc; then
		epatch ${FILESDIR}/${PV}-OSS.patch
	fi
}

src_compile() {
	need-autoconf 2.5
	econf $(use_enable jack jack-support) \
	      $(use_enable alsa alsa-seq) \
	      $(use_enable ladspa lrdf-support) \
	      || die "Failed configuring hydrogen!"
	emake || die "Failed making hydrogen!"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO

	newicon hydrogen_gui/img/icon32.png hydrogen.png
	make_desktop_entry hydrogen hydrogen hydrogen.png Audio
}
