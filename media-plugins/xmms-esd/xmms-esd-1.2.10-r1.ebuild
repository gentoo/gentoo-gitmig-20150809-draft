# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-esd/xmms-esd-1.2.10-r1.ebuild,v 1.7 2005/04/08 17:38:21 hansmi Exp $

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 sparc x86"
IUSE="oss"

DEPEND=">=media-sound/xmms-1.2.10
	>=media-sound/esound-0.2.22"

PATCH_VER="2.2.2"

PLUGIN_PATH="Output/esd"

M4_VER="1.1"

inherit xmms-plugin

src_unpack() {
	xmms-plugin_src_unpack

	cd ${S}/${PLUGIN_PATH}
	cp ../OSS/soundcard.h .

	sed -i 's:<Output/OSS/soundcard.h>:"soundcard.h":' *.{h,c}
}

src_compile() {
	myconf="--enable-esd $(use_enable oss)"
	xmms-plugin_src_compile
}
