# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-kfile-plugins/kdemultimedia-kfile-plugins-3.5.0.ebuild,v 1.1 2005/11/22 22:14:03 danarmak Exp $

KMNAME=kdemultimedia
KMMODULE=kfile-plugins
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kfile plugins from kdemultimedia package"
KEYWORDS="~amd64 ~x86"
IUSE="vorbis theora"
DEPEND="media-libs/taglib
	vorbis? ( media-libs/libvorbis )
	theora? ( media-libs/libtheora )"

src_compile() {
	myconf="$myconf $(use_with vorbis)"
	kde-meta_src_compile
}
