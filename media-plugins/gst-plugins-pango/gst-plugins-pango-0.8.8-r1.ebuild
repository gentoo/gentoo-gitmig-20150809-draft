# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pango/gst-plugins-pango-0.8.8-r1.ebuild,v 1.5 2005/05/06 12:05:59 corsair Exp $

inherit gst-plugins

KEYWORDS="x86 ~ppc amd64 ~sparc ~ia64 ~ppc64"

IUSE=""
DEPEND="x11-libs/pango"

src_unpack() {

	gst-plugins_src_unpack

	cd ${S}/ext/pango
	# fix subtitle crop at bottom
	epatch ${FILESDIR}/${P}-sub_position.patch

}
