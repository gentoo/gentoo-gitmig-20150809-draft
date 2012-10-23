# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pulse/gst-plugins-pulse-0.10.31.ebuild,v 1.1 2012/10/23 07:57:12 tetromino Exp $

EAPI=4

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for the PulseAudio sound server"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

# >=0.98 is the latest suggested dep for some optional features/best behaviour not available before
RDEPEND=">=media-sound/pulseaudio-0.98
	>=media-libs/gst-plugins-base-0.10.36"
DEPEND="${RDEPEND}"
