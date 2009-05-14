# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-twolame/gst-plugins-twolame-0.10.11.ebuild,v 1.4 2009/05/14 19:54:57 maekke Exp $

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-sound/twolame-0.3.0
	>=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
