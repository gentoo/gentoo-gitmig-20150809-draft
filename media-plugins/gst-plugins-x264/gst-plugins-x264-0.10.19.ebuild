# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-x264/gst-plugins-x264-0.10.19.ebuild,v 1.2 2012/12/05 22:59:56 eva Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="~amd64 ~x86"
IUSE=""

# 20111220 ensures us X264_BUILD >= 120
RDEPEND=">=media-libs/x264-0.0.20111220"
DEPEND="${RDEPEND}"
