# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-oss/xmms-oss-1.2.10.ebuild,v 1.7 2005/04/08 17:40:01 hansmi Exp $

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 sparc x86"
IUSE=""

DEPEND=">=media-sound/xmms-1.2.10"

PLUGIN_PATH="Output/OSS"

M4_VER="1.1"

inherit xmms-plugin

src_compile() {
	myconf="${myconf} --enable-oss"
	xmms-plugin_src_compile
}
