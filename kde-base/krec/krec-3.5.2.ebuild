# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krec/krec-3.5.2.ebuild,v 1.7 2006/05/29 21:47:30 weeve Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE sound recorder"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ppc64 sparc x86"
IUSE="encode mp3 vorbis"

DEPEND="$(deprange $PV $MAXKDEVER kde-base/kdemultimedia-arts)
	encode? ( mp3? ( media-sound/lame )
	          vorbis? ( media-libs/libvorbis ) )"

KMCOMPILEONLY="arts"

pkg_setup() {
	if ! useq arts; then
		eerror "${PN} needs the USE=\"arts\" enabled and also the kdelibs compiled with the USE=\"arts\" enabled"
		die
	fi
	kde_pkg_setup
}

src_compile() {
	if use encode; then
		myconf="$(use_with mp3 lame) $(use_with vorbis)"
	else
		myconf="--without-lame --without-vorbis"
	fi

	kde-meta_src_compile
}
