# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dv/gst-plugins-dv-0.6.4.ebuild,v 1.4 2005/03/17 12:22:23 zaheerm Exp $

inherit gst-plugins

KEYWORDS="x86"

IUSE=""
DEPEND=">=media-libs/libdv-0.9.5"

BUILD_GST_PLUGINS="libdv"
