# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-vorbis/xmms-vorbis-1.2.10-r1.ebuild,v 1.13 2006/07/05 06:11:25 vapier Exp $

PATCH_VER="2.2.2"
M4_VER="1.1"
inherit xmms-plugin

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE="ipv6 ssl"

DEPEND=">=media-sound/xmms-1.2.10-r12
	media-libs/libvorbis
	ssl? ( dev-libs/openssl )"

PLUGIN_PATH="Input/vorbis"

src_compile() {
	myconf="${myconf} --enable-vorbis $(use_enable ipv6) $(use_enable ssl)"
	xmms-plugin_src_compile
}
