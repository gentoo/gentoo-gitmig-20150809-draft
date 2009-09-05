# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gstreamer/ruby-gstreamer-0.19.0.ebuild,v 1.1 2009/09/05 13:10:57 graaff Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GStreamer bindings"
KEYWORDS="~amd64 ~x86"
IUSE=""
USE_RUBY="ruby18"
RDEPEND="=media-libs/gstreamer-0.10*
	=media-libs/gst-plugins-base-0.10*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
