# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vorbis/gst-plugins-vorbis-0.6.4.ebuild,v 1.6 2004/01/29 05:06:42 agriffis Exp $

inherit gst-plugins

KEYWORDS="x86 ~ppc alpha sparc hppa ~amd64 ia64"

IUSE=""
RDEPEND="media-libs/libvorbis
	media-libs/libogg"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

