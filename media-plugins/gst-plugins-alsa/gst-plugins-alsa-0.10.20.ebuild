# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-alsa/gst-plugins-alsa-0.10.20.ebuild,v 1.3 2008/07/30 13:25:58 ranger Exp $

inherit gst-plugins-base

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.20
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
