# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vorbis/gst-plugins-vorbis-0.6.4.ebuild,v 1.11 2004/06/24 23:31:28 agriffis Exp $

inherit gst-plugins

KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64 mips"

IUSE=""
RDEPEND="media-libs/libvorbis
	media-libs/libogg"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

