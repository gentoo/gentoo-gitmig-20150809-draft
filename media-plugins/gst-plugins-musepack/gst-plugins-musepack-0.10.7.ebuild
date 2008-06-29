# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-musepack/gst-plugins-musepack-0.10.7.ebuild,v 1.1 2008/06/29 18:18:05 drac Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=media-libs/gst-plugins-base-0.10.19
	>=media-libs/gstreamer-0.10.19
	>=media-libs/libmpcdec-1.2"
