# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sweep/sweep-0.8.2-r1.ebuild,v 1.6 2004/04/01 08:27:58 eradicator Exp $

inherit eutils

DESCRIPTION="audio editor and live playback tool"
HOMEPAGE="http://www.metadecks.org/software/sweep/"
SRC_URI="http://www.metadecks.org/software/sweep/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
IUSE="oggvorbis alsa nls"

DEPEND=">=media-libs/libsndfile-1.0*
		>=x11-libs/gtk+-1.2*
		>=media-sound/mad-0.14.2b
		dev-libs/tdb
		media-libs/libsamplerate
		media-libs/speex
		oggvorbis? ( media-libs/libogg media-libs/libvorbis )
		alsa? ( media-libs/alsa-lib )
		nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-alsa.patch
}

src_compile() {
	local myconf
	myconf=""

	# --enable-experimental       Add to myconf if you want this stuff 

	use oggvorbis || myconf="${myconf} --disable-oggvorbis"
	use alsa && myconf="${myconf} --enable-alsa"
	use nls  || myconf="${myconf} --disable-nls"

	econf ${myconf}
	emake
}

src_install() {
	einstall
}

pkg_postinst() {
	einfo ""
	einfo "Sweep can use ladspa plugins,"
	einfo "emerge ladspa-sdk and ladspa-cmt if you want them."
	einfo ""
}
