# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sweep/sweep-0.8.3.ebuild,v 1.11 2007/01/05 18:08:47 flameeyes Exp $

inherit eutils

DESCRIPTION="audio editor and live playback tool"
HOMEPAGE="http://www.metadecks.org/software/sweep/"
SRC_URI="http://www.metadecks.org/software/sweep/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE="alsa nls vorbis"

DEPEND="media-libs/libsamplerate
	>=media-libs/libsndfile-1.0
	media-libs/speex
	>=media-sound/madplay-0.14.2b
	=x11-libs/gtk+-1.2*
	alsa? ( media-libs/alsa-lib )
	nls? ( sys-devel/gettext )
	vorbis? ( media-libs/libogg media-libs/libvorbis )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-alsa.patch
}

src_compile() {
	econf \
		$(use_enable alsa) \
		$(use_enable nls) \
		$(use_enable vorbis) \
		|| die "econf failed"

	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"
}

pkg_postinst() {
	elog
	elog "Sweep can use ladspa plugins,"
	elog "emerge ladspa-sdk and ladspa-cmt if you want them."
	elog
}
