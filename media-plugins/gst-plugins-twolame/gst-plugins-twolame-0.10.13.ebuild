# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-twolame/gst-plugins-twolame-0.10.13.ebuild,v 1.6 2010/08/05 20:12:23 ssuominen Exp $

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-sound/twolame-0.3.10
	>=media-libs/gstreamer-0.10.25
	>=media-libs/gst-plugins-base-0.10.25"
DEPEND="${RDEPEND}"
