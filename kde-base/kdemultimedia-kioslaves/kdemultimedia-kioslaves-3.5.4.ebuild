# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-kioslaves/kdemultimedia-kioslaves-3.5.4.ebuild,v 1.2 2006/10/21 11:49:03 flameeyes Exp $

KMNAME=kdemultimedia
KMMODULE=kioslave
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kioslaves from kdemultimedia package"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="encode flac mp3 vorbis"
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkcddb)
	media-sound/cdparanoia
	media-libs/taglib
	encode? ( vorbis? ( media-libs/libvorbis )
	          flac? ( ~media-libs/flac-1.1.2 ) )"
RDEPEND="${DEPEND}
	encode? ( mp3? ( media-sound/lame ) )"

KMCOPYLIB="libkcddb libkcddb"
KMEXTRACTONLY="akode/configure.in.in"
KMCOMPILEONLY="
	kscd
	kscd/libwm
	libkcddb"

src_compile() {
	myconf="--with-cdparanoia --enable-cdparanoia"
	if use encode; then
		myconf="$myconf $(use_with vorbis) $(use_with flac)"
	else
		myconf="$myconf --without-vorbis --without-flac"
	fi

	DO_NOT_COMPILE="libkcddb kscd" kde-meta_src_compile myconf configure
	cd $S/libkcddb && make configbase.h cdinfodialogbase.h

	# Library deps seems not to be built as they should :/
	cd $S/kscd/libwm/audio && make libworkmanaudio.la && \
	cd $S/kscd/libwm && make libworkman.la && \
	cd $S/kscd && make libkcompactdisc.la || \
		die "failed to make prerequisite libraries."

	DO_NOT_COMPILE="libkcddb kscd" kde-meta_src_compile make
}
