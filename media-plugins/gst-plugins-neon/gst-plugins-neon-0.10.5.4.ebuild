# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.5.4.ebuild,v 1.1 2008/02/20 19:25:59 drac Exp $

inherit gst-plugins-bad

MY_PN=${PN/neon/bad}
SRC_URI="http://gstreamer.freedesktop.org/src/${MY_PN}/pre/${MY_PN}-${PV}.tar.bz2"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=net-misc/neon-0.26.4
	>=media-libs/gstreamer-0.10.17
	>=media-libs/gst-plugins-base-0.10.17"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
