# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vorbis/gst-plugins-vorbis-0.6.4.ebuild,v 1.7 2004/02/10 06:05:33 darkspecter Exp $

inherit gst-plugins

KEYWORDS="x86 ppc alpha sparc hppa ~amd64 ia64"

IUSE=""
RDEPEND="media-libs/libvorbis
	media-libs/libogg"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

