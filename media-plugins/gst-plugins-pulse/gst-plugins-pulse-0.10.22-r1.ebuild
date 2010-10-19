# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pulse/gst-plugins-pulse-0.10.22-r1.ebuild,v 1.5 2010/10/19 02:27:11 jer Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for the PulseAudio sound server"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~ppc ~ppc64 ~sh sparc x86"
IUSE=""

# >=0.9.15 ensures working per-stream volume
RDEPEND=">=media-sound/pulseaudio-0.9.15
	>=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}"

src_unpack() {
	gst-plugins-good_src_unpack
	cd "${S}"

	# These fix a couple of races condition that can lead to a crash. See
	# bug #330401 for details.
	epatch "${FILESDIR}/0001-pulsesink-Create-and-free-the-PA-mainloop-in-NULL-RE.patch"
	epatch "${FILESDIR}/0002-pulsesink-Allocate-and-free-the-custom-clock-in-NULL.patch"
	epatch "${FILESDIR}/0003-pulsesrc-Allocate-free-PA-mainloop-during-state-chan.patch"
	epatch "${FILESDIR}/0004-pulse-Don-t-lock-the-mainloop-in-NULL.patch"
	epatch "${FILESDIR}/0005-pulsesink-Post-provide-clock-message-on-the-bus-if-t.patch"
}
