# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-wavpack/gst-plugins-wavpack-0.10.23.ebuild,v 1.5 2011/01/30 18:07:46 jer Exp $

inherit gst-plugins-good

KEYWORDS="alpha amd64 ~hppa ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.29
	>=media-sound/wavpack-4.40"
DEPEND="${RDEPEND}"
