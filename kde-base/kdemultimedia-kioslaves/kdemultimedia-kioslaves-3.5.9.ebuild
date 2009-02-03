# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-kioslaves/kdemultimedia-kioslaves-3.5.9.ebuild,v 1.8 2009/02/03 04:14:35 jmbsvicetto Exp $

KMNAME=kdemultimedia
KMMODULE=kioslave
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="kioslaves from kdemultimedia package"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="encode flac mp3 vorbis"
DEPEND=">=kde-base/libkcddb-${PV}:${SLOT}
	media-sound/cdparanoia
	media-libs/taglib
	encode? ( vorbis? ( media-libs/libvorbis )
			flac? ( >=media-libs/flac-1.1.2 ) )"
RDEPEND="${DEPEND}
	encode? ( mp3? ( media-sound/lame ) )"

KMCOPYLIB="libkcddb libkcddb"
KMEXTRACTONLY="akode/configure.in.in"
KMCOMPILEONLY="
	kscd
	kscd/libwm
	libkcddb"

PATCHES=( "${FILESDIR}/kdemultimedia-3.5.5+flac-1.1.3.patch"
	"${FILESDIR}/kdemultimedia-kioslaves-3.5.6-arts.patch"
	"${FILESDIR}/kdemultimedia-kioslaves-3.5.8-freebsd.patch" )

src_compile() {
	myconf="--with-cdparanoia --enable-cdparanoia"
	if use encode; then
		myconf="$myconf $(use_with vorbis) $(use_with flac)"
	else
		myconf="$myconf --without-vorbis --without-flac"
	fi

	DO_NOT_COMPILE="libkcddb kscd" kde-meta_src_compile myconf configure
	cd "${S}"/libkcddb && emake configbase.h cdinfodialogbase.h

	# Library deps seems not to be built as they should :/
	cd "${S}"/kscd/libwm/audio && emake libworkmanaudio.la && \
	cd "${S}"/kscd/libwm && emake libworkman.la && \
	cd "${S}"/kscd && emake libkcompactdisc.la || \
		die "failed to make prerequisite libraries."

	DO_NOT_COMPILE="libkcddb kscd" kde-meta_src_compile make
}
