# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gio/gst-plugins-gio-0.10.20.ebuild,v 1.4 2008/08/18 22:29:22 remi Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.20
	>=dev-libs/glib-2.15.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
