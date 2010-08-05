# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-lame/gst-plugins-lame-0.10.13.ebuild,v 1.7 2010/08/05 20:11:25 ssuominen Exp $

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ~hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-sound/lame-3.95
	>=media-libs/gstreamer-0.10.25
	>=media-libs/gst-plugins-base-0.10.25"
DEPEND="${RDEPEND}"
