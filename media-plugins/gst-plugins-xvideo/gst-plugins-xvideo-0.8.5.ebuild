# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-xvideo/gst-plugins-xvideo-0.8.5.ebuild,v 1.1 2004/10/21 22:58:58 foser Exp $

inherit gst-plugins

KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""
DEPEND="virtual/x11"

# xshm is a compile time option of xvideo
GST_PLUGINS_BUILD="x xvideo xshm"
GST_PLUGINS_BUILD_DIR="xvimage"
