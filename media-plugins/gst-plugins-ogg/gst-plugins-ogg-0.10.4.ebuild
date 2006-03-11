# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ogg/gst-plugins-ogg-0.10.4.ebuild,v 1.1 2006/03/11 22:12:47 compnerd Exp $

inherit gst-plugins-base

KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=media-libs/libogg-1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
