# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-colorspace/gst-plugins-colorspace-0.6.4.ebuild,v 1.9 2004/06/24 23:28:57 agriffis Exp $

inherit gst-plugins

KEYWORDS="x86 ppc sparc ~amd64"

IUSE=""
DEPEND="media-libs/hermes"

GST_PLUGINS_BUILD="hermes"
GST_PLUGINS_BUILD_DIR="hermes"
