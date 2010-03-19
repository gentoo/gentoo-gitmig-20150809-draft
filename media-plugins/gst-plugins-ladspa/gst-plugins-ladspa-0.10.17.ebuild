# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ladspa/gst-plugins-ladspa-0.10.17.ebuild,v 1.2 2010/03/19 09:46:48 pacho Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=media-libs/ladspa-sdk-1.12-r2
	>=media-libs/gst-plugins-base-0.10.25
	>=media-libs/gstreamer-0.10.25
	>=media-libs/gst-plugins-bad-${PV}"
DEPEND="${RDEPEND}
	=media-libs/gst-plugins-bad-${PV}
	dev-util/pkgconfig"
