# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vorbis/gst-plugins-vorbis-0.8.1.ebuild,v 1.10 2005/02/12 14:25:23 nigoro Exp $

inherit gst-plugins

KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/libvorbis-1"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
