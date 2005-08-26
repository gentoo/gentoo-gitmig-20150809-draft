# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sweep/sweep-0.8.3.ebuild,v 1.6 2005/08/26 18:58:25 gustavoz Exp $

inherit eutils

DESCRIPTION="audio editor and live playback tool"
HOMEPAGE="http://www.metadecks.org/software/sweep/"
SRC_URI="http://www.metadecks.org/software/sweep/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~alpha amd64"
IUSE="alsa nls vorbis"

DEPEND="dev-libs/tdb
	media-libs/libsamplerate
	>=media-libs/libsndfile-1.0
	media-libs/speex
	>=media-sound/madplay-0.14.2b
	>=x11-libs/gtk+-1.2
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
		$(use_enable vorbis oggvorbis) \
		|| die "econf failed"

	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"
}

pkg_postinst() {
	einfo
	einfo "Sweep can use ladspa plugins,"
	einfo "emerge ladspa-sdk and ladspa-cmt if you want them."
	einfo
}
