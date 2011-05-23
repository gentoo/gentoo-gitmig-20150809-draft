# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-twolame/gst-plugins-twolame-0.10.17.ebuild,v 1.3 2011/05/23 14:56:15 hwoarang Exp $

inherit gst-plugins-ugly

KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-sound/twolame-0.3.10
	>=media-libs/gstreamer-0.10.26
	>=media-libs/gst-plugins-base-0.10.26"
DEPEND="${RDEPEND}"
