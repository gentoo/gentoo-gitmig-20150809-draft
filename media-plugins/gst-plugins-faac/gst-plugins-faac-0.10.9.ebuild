# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faac/gst-plugins-faac-0.10.9.ebuild,v 1.1 2008/12/05 22:46:01 ssuominen Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="media-libs/faac
	>=media-libs/gst-plugins-base-0.10.21
	>=media-libs/gstreamer-0.10.21"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
