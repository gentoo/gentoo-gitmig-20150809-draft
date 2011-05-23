# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-annodex/gst-plugins-annodex-0.10.28.ebuild,v 1.3 2011/05/23 14:50:10 hwoarang Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for annodex stream manipulation"

KEYWORDS="~alpha amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.32
	>=dev-libs/libxml2-2.4.9"
DEPEND="${RDEPEND}"
