# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-modplug/gst-plugins-modplug-0.10.18.ebuild,v 1.5 2010/08/05 20:24:49 ssuominen Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="media-libs/libmodplug
	>=media-libs/gst-plugins-base-0.10.27"
DEPEND="${RDEPEND}
	!<media-libs/gst-plugins-bad-0.10.11"
