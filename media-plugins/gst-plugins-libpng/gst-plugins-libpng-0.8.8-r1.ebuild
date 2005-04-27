# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libpng/gst-plugins-libpng-0.8.8-r1.ebuild,v 1.3 2005/04/27 12:49:20 luckyduck Exp $

inherit gst-plugins

DESCRIPTION="plug-in to encode png images"

KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa amd64 ~ia64 ~mips"
IUSE=""

DEPEND=">=media-libs/libpng-1.2"

src_unpack() {

	gst-plugins_src_unpack

	# fixes pngenc
	cd ${S}/ext/libpng
	epatch ${FILESDIR}/${P}-colorspace.patch

}
