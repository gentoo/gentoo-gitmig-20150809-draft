# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-vorbis/xmms-vorbis-1.2.10-r1.ebuild,v 1.12 2005/07/12 05:02:11 geoman Exp $

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE="ipv6 ssl"

DEPEND=">=media-sound/xmms-1.2.10-r12
	media-libs/libvorbis
	ssl? ( dev-libs/openssl )"

PATCH_VER="2.2.2"

PLUGIN_PATH="Input/vorbis"

M4_VER="1.1"

inherit xmms-plugin

src_compile() {
	myconf="${myconf} --enable-vorbis $(use_enable ipv6) $(use_enable ssl)"
	xmms-plugin_src_compile
}
