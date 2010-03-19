# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faad/gst-plugins-faad-0.10.17.ebuild,v 1.2 2010/03/19 09:46:02 pacho Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/faad2
	>=media-libs/gst-plugins-base-0.10.25
	>=media-libs/gstreamer-0.10.25"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
