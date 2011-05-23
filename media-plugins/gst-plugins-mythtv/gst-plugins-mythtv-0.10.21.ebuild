# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mythtv/gst-plugins-mythtv-0.10.21.ebuild,v 1.3 2011/05/23 14:58:48 hwoarang Exp $

inherit gst-plugins-bad

DESCRIPION="plugin to allow retrieving from a mythbackend"

KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/gmyth-0.4
	<=media-libs/gmyth-0.7.99
	>=media-libs/gst-plugins-base-0.10.32"
DEPEND="${RDEPEND}"
