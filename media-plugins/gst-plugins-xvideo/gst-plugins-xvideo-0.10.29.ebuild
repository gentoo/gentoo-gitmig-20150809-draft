# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-xvideo/gst-plugins-xvideo-0.10.29.ebuild,v 1.3 2010/07/27 17:35:16 pacho Exp $

inherit gst-plugins-base

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libXv
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/videoproto
	x11-proto/xproto
	x11-proto/xextproto"

# xshm is a compile time option of xvideo
# x is needed to build any X plugins, but we build/install only xv anyway
GST_PLUGINS_BUILD="x xvideo xshm"
GST_PLUGINS_BUILD_DIR="xvimage"
