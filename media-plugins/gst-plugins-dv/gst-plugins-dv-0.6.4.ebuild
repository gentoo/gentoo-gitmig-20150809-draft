# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dv/gst-plugins-dv-0.6.4.ebuild,v 1.3 2004/06/24 23:29:08 agriffis Exp $

inherit gst-plugins

KEYWORDS="x86"

IUSE=""
DEPEND=">=media-libs/libdv-0.9.5"

BUILD_GST_PLUGINS="libdv"
