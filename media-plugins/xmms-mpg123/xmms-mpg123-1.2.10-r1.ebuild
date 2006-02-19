# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-mpg123/xmms-mpg123-1.2.10-r1.ebuild,v 1.14 2006/02/19 07:45:00 nigoro Exp $

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE="ipv6 ssl mmx 3dnow"

DEPEND=">=media-sound/xmms-1.2.10-r12
	ssl? ( dev-libs/openssl )"

PATCH_VER="2.2.2"

PLUGIN_PATH="Input/mpg123"

M4_VER="1.1"

inherit xmms-plugin

src_compile() {
	myconf="${myconf} --enable-mpg123 $(use_enable ipv6) $(use_enable ssl)"

	if use x86 && ! has_pic && { use mmx || use 3dnow; }; then
		myconf="${myconf} --enable-simd"
	else
		myconf="${myconf} --disable-simd"
	fi

	# Please see Bug 58092 for details
	use ppc64 && replace-flags "-O[2-9]" "-O1"

	xmms-plugin_src_compile
}
