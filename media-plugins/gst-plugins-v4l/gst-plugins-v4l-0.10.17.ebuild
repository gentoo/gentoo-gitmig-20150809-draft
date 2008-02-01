# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-v4l/gst-plugins-v4l-0.10.17.ebuild,v 1.1 2008/02/01 12:58:31 drac Exp $

inherit gst-plugins-base

KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.17"
DEPEND="virtual/os-headers
	dev-util/pkgconfig"
