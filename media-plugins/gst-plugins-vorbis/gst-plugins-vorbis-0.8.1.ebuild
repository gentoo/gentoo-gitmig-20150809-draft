# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vorbis/gst-plugins-vorbis-0.8.1.ebuild,v 1.3 2004/05/26 01:13:01 gmsoft Exp $

inherit gst-plugins

KEYWORDS="x86 ~ppc ~alpha ~sparc hppa ~amd64 ~ia64 ~mips"

IUSE=""
RDEPEND=">=media-libs/libvorbis-1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
