# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sweep/sweep-0.8.2-r1.ebuild,v 1.1 2003/07/17 21:57:15 raker Exp $

IUSE="oggvorbis alsa nls"

DESCRIPTION="Sweep is an audio editor and live playback tool"
HOMEPAGE="http://www.metadecks.org/software/sweep/"
SRC_URI="http://www.metadecks.org/software/sweep/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~mips ~alpha"

DEPEND=">=media-libs/libsndfile-1.0*
		>=x11-libs/gtk+-1.2*
		dev-libs/tdb
		media-libs/libsamplerate
		media-libs/libmad
		media-libs/libid3tag
		media-libs/speex
		oggvorbis? ( media-libs/libogg media-libs/libvorbis )
		alsa? ( media-libs/alsa-lib )
		nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

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
