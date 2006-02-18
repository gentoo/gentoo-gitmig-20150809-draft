# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-xvideo/gst-plugins-xvideo-0.8.11.ebuild,v 1.10 2006/02/18 22:07:12 agriffis Exp $

inherit gst-plugins

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"

IUSE=""
DEPEND="|| ( x11-libs/libXv virtual/x11 )"

# xshm is a compile time option of xvideo
GST_PLUGINS_BUILD="x xvideo xshm"
GST_PLUGINS_BUILD_DIR="xvimage"
