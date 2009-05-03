# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pulse/gst-plugins-pulse-0.10.14.ebuild,v 1.2 2009/05/03 17:44:24 klausman Exp $

inherit gst-plugins-good

DESCRIPTION="gst-pulse is a GStreamer 0.10 plugin for the PulseAudio sound
server."
KEYWORDS="alpha ~amd64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-sound/pulseaudio-0.9.8
	>=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
