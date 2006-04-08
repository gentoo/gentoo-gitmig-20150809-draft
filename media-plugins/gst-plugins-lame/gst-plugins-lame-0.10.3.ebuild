# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-lame/gst-plugins-lame-0.10.3.ebuild,v 1.2 2006/04/08 12:40:22 dertobi123 Exp $

inherit gst-plugins-ugly

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=media-sound/lame-3.95
	 >=media-libs/gstreamer-0.10.3
	 >=media-libs/gst-plugins-base-0.10.3"

DEPEND="${RDEPEND}"
