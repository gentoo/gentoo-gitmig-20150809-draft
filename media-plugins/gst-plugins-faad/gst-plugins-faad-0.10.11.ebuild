# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faad/gst-plugins-faad-0.10.11.ebuild,v 1.3 2009/05/12 21:14:54 fauli Exp $

inherit gst-plugins-bad

KEYWORDS="alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/faad2
	>=media-libs/gst-plugins-base-0.10.22
	>=media-libs/gstreamer-0.10.22"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
