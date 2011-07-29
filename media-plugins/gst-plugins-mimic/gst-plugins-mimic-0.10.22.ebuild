# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mimic/gst-plugins-mimic-0.10.22.ebuild,v 1.1 2011/07/29 08:41:31 leio Exp $

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for the MIMIC codec"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.33
	>=media-libs/libmimic-1.0.4"
DEPEND="${RDEPEND}"
