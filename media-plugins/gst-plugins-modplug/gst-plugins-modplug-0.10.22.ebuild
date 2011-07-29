# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-modplug/gst-plugins-modplug-0.10.22.ebuild,v 1.1 2011/07/29 08:42:36 leio Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="media-libs/libmodplug
	>=media-libs/gst-plugins-base-0.10.33"
DEPEND="${RDEPEND}"
