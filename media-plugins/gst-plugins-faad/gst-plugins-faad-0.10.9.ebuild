# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faad/gst-plugins-faad-0.10.9.ebuild,v 1.1 2008/12/05 22:45:57 ssuominen Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/faad2
	>=media-libs/gst-plugins-base-0.10.21
	>=media-libs/gstreamer-0.10.21"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
