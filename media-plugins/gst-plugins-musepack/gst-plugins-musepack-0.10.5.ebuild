# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-musepack/gst-plugins-musepack-0.10.5.ebuild,v 1.4 2007/09/21 19:26:11 wolf31o2 Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ppc ~ppc64 ~sparc x86"

RDEPEND=">=media-libs/gst-plugins-base-0.10.13
	>=media-libs/gstreamer-0.10.13
	>=media-libs/libmpcdec-1.2"

DEPEND="${RDEPEND}"
