# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ladspa/gst-plugins-ladspa-0.10.19.ebuild,v 1.3 2010/12/20 17:20:52 hwoarang Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/ladspa-sdk-1.12-r2
	>=media-libs/gst-plugins-base-0.10.29
	>=media-libs/gst-plugins-bad-${PV}" # uses signalprocessor helper library
DEPEND="${RDEPEND}
	~media-libs/gst-plugins-bad-${PV}"
