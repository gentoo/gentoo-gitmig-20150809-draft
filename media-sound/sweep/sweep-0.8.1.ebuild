# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sweep/sweep-0.8.1.ebuild,v 1.2 2003/07/12 20:31:00 aliz Exp $

DESCRIPTION="Sweep is an audio editor and live playback tool for GNU/Linux, BSD and compatible systems."
HOMEPAGE="http://www.metadecks.org/software/sweep/"
SRC_URI="mirror://sourceforge/sweep/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~hppa ~mips ~alpha"

IUSE="alsa oggvorbis"

DEPEND=">=x11-libs/gtk+-1.2
	>=media-libs/libsndfile-1.0
	media-libs/libsamplerate
	dev-libs/tdb
	dev-util/pkgconfig
	oggvorbis? ( >=media-libs/libvorbis-1.0-r2 media-libs/libogg )
	media-sound/mad
	media-libs/speex
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc1 )"

S=${WORKDIR}/${P}

src_compile() {
	local myconf
	use alsa && myconf="--enable-alsa"
	use oggvorbis || myconf="${myconf} --disable-oggvorbis"
	econf ${myconf}
	emake || die
}

src_install() {
	einstall
}

