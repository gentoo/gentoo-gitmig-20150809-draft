# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krec/krec-3.5.9.ebuild,v 1.6 2008/05/14 17:15:12 corsair Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE sound recorder"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="encode mp3 vorbis"

DEPEND=">=kde-base/kdemultimedia-arts-${PV}:${SLOT}
	encode? ( mp3? ( media-sound/lame )
			vorbis? ( media-libs/libvorbis ) )"
RDEPEND="${DEPEND}"

KMCOMPILEONLY="arts"

src_compile() {
	if use encode; then
		myconf="$(use_with mp3 lame) $(use_with vorbis)"
	else
		myconf="--without-lame --without-vorbis"
	fi

	kde-meta_src_compile
}
