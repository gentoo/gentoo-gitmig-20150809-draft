# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-x264/gst-plugins-x264-0.10.13.ebuild,v 1.2 2009/11/17 04:42:28 mr_bones_ Exp $

inherit eutils gst-plugins-ugly

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=media-libs/x264-0.0.20081006
	>=media-libs/gstreamer-0.10.25
	>=media-libs/gst-plugins-base-0.10.25"
DEPEND="${RDEPEND}"

src_unpack()
{
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/gst-plugins-x264-0.10.13-x264-api-change-1.patch"
}
