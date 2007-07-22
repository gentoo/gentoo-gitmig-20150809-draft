# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-v4l2/gst-plugins-v4l2-0.8.11.ebuild,v 1.7 2007/07/22 09:19:40 dberkholz Exp $

inherit gst-plugins

DESCRIPION="plugin to allow capture from video4linux2 devices"

KEYWORDS="amd64 ppc x86"

IUSE=""

RDEPEND="x11-libs/libXv
	>=sys-kernel/linux-headers-2.6"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
