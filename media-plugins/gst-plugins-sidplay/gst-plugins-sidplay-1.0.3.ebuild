# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-sidplay/gst-plugins-sidplay-1.0.3.ebuild,v 1.1 2012/12/05 22:57:39 eva Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/libsidplay-1.3:1"
DEPEND="${RDEPEND}"
