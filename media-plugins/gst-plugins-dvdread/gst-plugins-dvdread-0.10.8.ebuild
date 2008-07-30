# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dvdread/gst-plugins-dvdread-0.10.8.ebuild,v 1.3 2008/07/30 13:28:32 ranger Exp $

inherit gst-plugins-ugly

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libdvdread
	>=media-libs/gstreamer-0.10.17
	>=media-libs/gst-plugins-base-0.10.17"
