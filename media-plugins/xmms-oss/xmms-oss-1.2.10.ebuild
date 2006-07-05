# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-oss/xmms-oss-1.2.10.ebuild,v 1.10 2006/07/05 06:10:56 vapier Exp $

M4_VER="1.1"
inherit xmms-plugin

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE=""

DEPEND=">=media-sound/xmms-1.2.10"

PLUGIN_PATH="Output/OSS"

src_compile() {
	myconf="${myconf} --enable-oss"
	xmms-plugin_src_compile
}
