# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vorbis/gst-plugins-vorbis-0.8.2.ebuild,v 1.3 2004/07/19 04:10:44 leonardop Exp $

inherit eutils gst-plugins

KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips"

IUSE=""
RDEPEND=">=media-libs/libvorbis-1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix some basic problems that break compilation under gcc-2.
	epatch ${FILESDIR}/${PN}-gcc2_fix.patch
}
