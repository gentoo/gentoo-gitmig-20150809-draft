# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gstreamer/ruby-gstreamer-1.0.0.ebuild,v 1.1 2011/09/19 02:50:59 naota Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby GStreamer bindings"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	=media-libs/gstreamer-0.10*
	=media-libs/gst-plugins-base-0.10*"
DEPEND="${DEPEND}
	=media-libs/gstreamer-0.10*
	=media-libs/gst-plugins-base-0.10*
	dev-util/pkgconfig"
