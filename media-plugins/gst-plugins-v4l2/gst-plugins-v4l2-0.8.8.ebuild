# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-v4l2/gst-plugins-v4l2-0.8.8.ebuild,v 1.1 2005/03/17 15:17:54 zaheerm Exp $

inherit gst-plugins

DESCRIPION="plugin to allow capture from video4linux2 devices"

KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""

RDEPEND="virtual/x11
	|| ( >=sys-kernel/linux-headers-2.6 sys-kernel/linux26-headers )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

