# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-jpeg/gst-plugins-jpeg-0.10.14.ebuild,v 1.2 2009/05/03 17:42:55 klausman Exp $

inherit gst-plugins-good

DESCRIPTION="plug-in to encode and decode jpeg images"
KEYWORDS="alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="media-libs/jpeg
	>=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
