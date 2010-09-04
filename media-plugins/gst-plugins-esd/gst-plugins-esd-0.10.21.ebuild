# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-esd/gst-plugins-esd-0.10.21.ebuild,v 1.8 2010/09/04 11:58:43 armin76 Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to output sound to esound"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

DEPEND=">=media-sound/esound-0.2.12
	>=media-libs/gstreamer-0.10.27
	>=media-libs/gst-plugins-base-0.10.27"
