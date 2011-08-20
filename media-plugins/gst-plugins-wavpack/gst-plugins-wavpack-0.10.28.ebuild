# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-wavpack/gst-plugins-wavpack-0.10.28.ebuild,v 1.5 2011/08/20 17:40:40 jer Exp $

inherit gst-plugins-good

KEYWORDS="~alpha amd64 hppa ppc ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.32
	>=media-sound/wavpack-4.40"
DEPEND="${RDEPEND}"
