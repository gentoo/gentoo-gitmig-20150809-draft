# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-theora/gst-plugins-theora-0.10.4.ebuild,v 1.7 2006/04/17 19:54:01 corsair Exp $

inherit gst-plugins-base

KEYWORDS="amd64 ~ppc ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/libtheora-1.0_alpha3
	>=media-libs/libogg-1
	>=media-libs/gst-plugins-base-0.10.4"
DEPEND="${RDEPEND}"
