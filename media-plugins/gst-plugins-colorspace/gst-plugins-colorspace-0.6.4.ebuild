# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-colorspace/gst-plugins-colorspace-0.6.4.ebuild,v 1.4 2004/01/14 20:12:19 gustavoz Exp $

inherit gst-plugins

KEYWORDS="x86 ~ppc ~sparc"

IUSE=""
DEPEND="media-libs/hermes"

BUILD_GST_PLUGINS="hermes"
GST_PLUGINS_BUILD_DIR="hermes"
