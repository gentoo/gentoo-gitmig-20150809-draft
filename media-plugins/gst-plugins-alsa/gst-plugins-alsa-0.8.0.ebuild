# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-alsa/gst-plugins-alsa-0.8.0.ebuild,v 1.3 2004/04/04 09:56:20 dholm Exp $

inherit gst-plugins

KEYWORDS="~x86 ~ppc"

IUSE=""
# should we depend on a kernel (?)
DEPEND=">=media-libs/alsa-lib-0.9.1"

pkg_postinst() {

	gst-plugins_pkg_postinst

	ewarn "This plugin has known problems on some hardware due to alsa bugs"

}
