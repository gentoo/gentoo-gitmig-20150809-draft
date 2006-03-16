# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-theora/gst-plugins-theora-0.10.4.ebuild,v 1.3 2006/03/16 23:19:06 corsair Exp $

inherit gst-plugins-base

KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND=">=media-libs/libtheora-1.0_alpha3
	>=media-libs/libogg-1
	>=media-libs/gst-plugins-base-0.10.4"
DEPEND="${RDEPEND}"
