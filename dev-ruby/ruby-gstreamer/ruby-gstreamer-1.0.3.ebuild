# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gstreamer/ruby-gstreamer-1.0.3.ebuild,v 1.4 2012/04/17 18:42:35 jdhore Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby GStreamer bindings"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="${RDEPEND}
	=media-libs/gstreamer-0.10*
	=media-libs/gst-plugins-base-0.10*"
DEPEND="${DEPEND}
	=media-libs/gstreamer-0.10*
	=media-libs/gst-plugins-base-0.10*
	dev-util/pkgconfig"
