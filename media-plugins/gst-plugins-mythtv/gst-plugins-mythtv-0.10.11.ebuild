# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mythtv/gst-plugins-mythtv-0.10.11.ebuild,v 1.3 2009/05/14 19:59:06 maekke Exp $

inherit gst-plugins-bad

DESCRIPION="plugin to allow retrieving from a mythbackend"

KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=media-libs/gmyth-0.4
	<=media-libs/gmyth-0.7.99
	>=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
