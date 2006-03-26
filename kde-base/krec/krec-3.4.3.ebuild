# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krec/krec-3.4.3.ebuild,v 1.8 2006/03/26 03:22:42 agriffis Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE sound recorder"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="vorbis encode"
OLDDEPEND="
	~kde-base/kdemultimedia-arts-$PV
	vorbis? ( media-libs/libvorbis )
	encode? ( media-sound/lame )"
DEPEND="$(deprange 3.4.1 $MAXKDEVER kde-base/kdemultimedia-arts)
	vorbis? ( media-libs/libvorbis )
	encode? ( media-sound/lame )"

KMCOPYLIB="libartsgui_kde arts/gui/kde/
	libartscontrolsupport arts/tools/"
KMEXTRACTONLY="
	arts/
	kioslave/audiocd/configure.in.in"

pkg_setup() {
	if ! useq arts; then
		eerror "${PN} needs the USE=\"arts\" enabled and also the kdelibs compiled with the USE=\"arts\" enabled"
		die
	fi
}

src_compile() {
	use vorbis && myconf="$myconf --with-vorbis=/usr" || myconf="$myconf --without-vorbis"
	use encode && myconf="$myconf --with-lame=/usr" || myconf="$myconf --without-lame"
	kde-meta_src_compile
}
