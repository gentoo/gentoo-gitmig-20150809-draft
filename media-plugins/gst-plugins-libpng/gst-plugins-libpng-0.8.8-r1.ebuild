# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libpng/gst-plugins-libpng-0.8.8-r1.ebuild,v 1.9 2005/07/12 04:42:29 geoman Exp $

inherit gst-plugins

DESCRIPTION="plug-in to encode png images"

KEYWORDS="alpha amd64 hppa ia64 mips ppc sparc x86"
IUSE=""

DEPEND=">=media-libs/libpng-1.2"

src_unpack() {

	gst-plugins_src_unpack

	# fixes pngenc
	cd ${S}/ext/libpng
	epatch ${FILESDIR}/${P}-colorspace.patch

}
