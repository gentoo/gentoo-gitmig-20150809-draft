# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-alsa/gst-plugins-alsa-0.8.5.ebuild,v 1.8 2005/01/25 00:43:56 eradicator Exp $

inherit eutils gst-plugins

KEYWORDS="x86 ppc amd64 ~ia64 ~mips hppa ~ppc64"
IUSE=""

# should we depend on a kernel (?)
DEPEND=">=media-libs/alsa-lib-0.9.1"

pkg_postinst() {

	gst-plugins_pkg_postinst

	ewarn "This plugin has known problems on some hardware due to alsa bugs"

}
