# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ogg/gst-plugins-ogg-0.8.2.ebuild,v 1.8 2004/11/08 20:25:35 vapier Exp $

inherit gst-plugins

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc sparc x86"
IUSE=""

RDEPEND=">=media-libs/libogg-1"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
