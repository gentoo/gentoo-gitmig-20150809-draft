# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pulse/gst-plugins-pulse-0.10.14.ebuild,v 1.9 2010/02/07 19:24:54 armin76 Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for the PulseAudio sound server"
KEYWORDS="alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh sparc x86"
IUSE=""

RDEPEND=">=media-sound/pulseaudio-0.9.8
	>=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
