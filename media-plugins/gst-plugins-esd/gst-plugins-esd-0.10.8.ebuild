# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-esd/gst-plugins-esd-0.10.8.ebuild,v 1.4 2008/07/31 16:58:49 ranger Exp $

inherit gst-plugins-good

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-sound/esound-0.2.8
	>=media-libs/gstreamer-0.10.18
	>=media-libs/gst-plugins-base-0.10.18"
