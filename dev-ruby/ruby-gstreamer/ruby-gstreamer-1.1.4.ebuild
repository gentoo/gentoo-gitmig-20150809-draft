# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gstreamer/ruby-gstreamer-1.1.4.ebuild,v 1.2 2012/09/09 08:50:23 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby GStreamer bindings"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10"
DEPEND="${DEPEND}
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10"
