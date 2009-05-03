# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.11.ebuild,v 1.2 2009/05/03 17:56:17 klausman Exp $

inherit gst-plugins-bad

KEYWORDS="alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=net-misc/neon-0.26
	>=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
