# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krec/krec-3.4.0.ebuild,v 1.4 2005/03/26 00:39:19 weeve Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE sound recorder"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="oggvorbis encode"
OLDDEPEND="
	~kde-base/kdemultimedia-arts-$PV
	oggvorbis? ( media-libs/libvorbis )
	encode? ( media-sound/lame )"
DEPEND="$(deprange $PV $MAXKDEVER kde-base/kdemultimedia-arts)
	oggvorbis? ( media-libs/libvorbis )
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
	use oggvorbis && myconf="$myconf --with-vorbis=/usr" || myconf="$myconf --without-vorbis"
	use encode && myconf="$myconf --with-lame=/usr" || myconf="$myconf --without-lame"
	kde-meta_src_compile
}