# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-kfile-plugins/kdemultimedia-kfile-plugins-3.5.10.ebuild,v 1.3 2009/06/03 14:12:14 ranger Exp $

KMNAME=kdemultimedia
KMMODULE=kfile-plugins
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="kfile plugins from kdemultimedia package"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="vorbis theora"
DEPEND="media-libs/taglib
	vorbis? ( media-libs/libvorbis )
	theora? (
		media-libs/libvorbis
		media-libs/libtheora )"

src_compile() {
	myconf="$myconf $(use_with vorbis)"
	kde-meta_src_compile
}
