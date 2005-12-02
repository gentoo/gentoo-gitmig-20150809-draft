# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-raw1394/gst-plugins-raw1394-0.9.7.ebuild,v 1.1 2005/12/02 22:39:04 zaheerm Exp $

inherit gst-plugins-good

KEYWORDS="~x86 ~amd64"

DESCRIPTION="GStreamer plugin to capture firewire video"

IUSE=""
RDEPEND="sys-libs/libraw1394
	sys-libs/libavc1394"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
