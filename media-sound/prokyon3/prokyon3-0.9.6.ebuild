# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/prokyon3/prokyon3-0.9.6.ebuild,v 1.1 2007/03/25 18:44:58 aballier Exp $

inherit qt3 eutils autotools

DESCRIPTION="Multithreaded music manager and tag editor based on Qt and MySQL."
HOMEPAGE="http://prokyon3.sourceforge.net"
SRC_URI="mirror://sourceforge/prokyon3/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="flac mp3 musicbrainz taglib vorbis"

DEPEND="$(qt_min_version 3.2)
	media-libs/taglib
	taglib? ( media-libs/taglib )
	musicbrainz? ( media-libs/musicbrainz
		mp3? ( media-libs/libmad )
		vorbis? ( media-libs/libvorbis )
		flac? ( media-libs/flac ) )"

pkg_setup() {
	if ! built_with_use =x11-libs/qt-3* mysql; then
		eerror "You have installed Qt without MySQL support."
		eerror "Please reemerge x11-libs/qt-3* with "mysql" in USE."
		die "MySQL support for Qt not found."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-cflags.patch"
	epatch "${FILESDIR}/${P}-qdir.patch"
	epatch "${FILESDIR}/${P}-flac113.patch"
	epatch "${FILESDIR}/${P}-asneeded.patch"
	eautoreconf
}

src_compile() {
	# Support for musicextras (not in portage)
	# requires dev-libs/xmlwrapp.

	local myconf="--with-taglib
			--without-id3
			--without-mysql-embedded
			--without-musicextras"

	if use musicbrainz; then
		myconf="${myconf}
			--with-musicbrainz
			$(use_with mp3 mad)
			$(use_with vorbis ogg)
			$(use_with flac)"
	else
		myconf="${myconf}
			--without-musicbrainz"
	fi

	econf ${myconf}	$(use_with taglib) || die "configure failed"
	emake || die "make failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	echo
	elog "Prokyon3 supports the following external programs"
	elog "to play audio tracks:"
	elog " - media-sound/amarok"
	elog " - media-sound/beep-media-player"
	elog " - media-video/kaffeine"
	elog " - media-video/mplayer"
	elog " - kde-base/noatun or kde-base/kdemultimedia"
	elog " - media-video/totem"
	elog " - media-sound/xmms"
	elog
	elog "Prokyon3 also supports the following external"
	elog "applications, if installed:"
	elog " - app-cdr/k3b:          CD burning"
	elog " - media-sound/mixxx:    DJ mixing"
	echo
}
