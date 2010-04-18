# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-taglib/gst-plugins-taglib-0.10.17.ebuild,v 1.6 2010/04/18 15:48:55 nixnut Exp $

inherit gst-plugins-good

KEYWORDS="alpha amd64 ~hppa ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.25
	>=media-libs/gstreamer-0.10.25
	>=media-libs/taglib-1.5"
DEPEND="${RDEPEND}"
