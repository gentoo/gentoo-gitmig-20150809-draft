# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mpeg2dec/gst-plugins-mpeg2dec-0.10.2.ebuild,v 1.1 2006/02/27 12:40:35 zaheerm Exp $

inherit gst-plugins-ugly

DESCRIPTION="Libmpeg2 based decoder plug-in for gstreamer"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.3
	>=media-libs/gstreamer-0.10.3
	>=media-libs/libmpeg2-0.4"
