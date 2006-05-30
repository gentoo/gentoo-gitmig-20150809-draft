# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krec/krec-3.4.3.ebuild,v 1.9 2006/05/30 01:25:09 flameeyes Exp $

ARTS_REQUIRED="yes"
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

src_compile() {
	use vorbis && myconf="$myconf --with-vorbis=/usr" || myconf="$myconf --without-vorbis"
	use encode && myconf="$myconf --with-lame=/usr" || myconf="$myconf --without-lame"
	kde-meta_src_compile
}
