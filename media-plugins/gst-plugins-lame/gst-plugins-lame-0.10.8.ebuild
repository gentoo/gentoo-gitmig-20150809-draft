# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-lame/gst-plugins-lame-0.10.8.ebuild,v 1.6 2008/08/07 21:35:06 klausman Exp $

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ppc ppc64 sparc ~x86"
IUSE=""

RDEPEND=">=media-sound/lame-3.95
	 >=media-libs/gstreamer-0.10.17
	 >=media-libs/gst-plugins-base-0.10.17"

DEPEND="${RDEPEND}"
