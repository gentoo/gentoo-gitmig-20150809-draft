# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-kfile-plugins/kdemultimedia-kfile-plugins-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:30 danarmak Exp $

KMNAME=kdemultimedia
KMMODULE=kfile-plugins
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kfile plugins from kdemultimedia package"
KEYWORDS="~x86"
IUSE="oggvorbis"
DEPEND="media-libs/taglib
	oggvorbis? ( media-libs/libvorbis )"

src_compile() {
	use oggvorbis	&& myconf="$myconf --with-vorbis=/usr" || myconf="$myconf --without-vorbis"
	kde-meta_src_compile
}