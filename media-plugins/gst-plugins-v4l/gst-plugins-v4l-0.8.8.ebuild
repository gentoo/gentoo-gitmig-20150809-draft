# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-v4l/gst-plugins-v4l-0.8.8.ebuild,v 1.2 2005/03/24 11:04:19 zaheerm Exp $

inherit gst-plugins

DESCRIPION="plugin to allow capture from video4linux1 devices"

KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""

RDEPEND="virtual/x11
	virtual/os-headers"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

