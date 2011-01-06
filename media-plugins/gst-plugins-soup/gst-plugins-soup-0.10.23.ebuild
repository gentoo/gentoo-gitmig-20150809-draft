# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-soup/gst-plugins-soup-0.10.23.ebuild,v 1.5 2011/01/06 17:11:34 armin76 Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for HTTP client sources"

KEYWORDS="alpha amd64 arm ~hppa ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.29
	>=net-libs/libsoup-2.26"
DEPEND="${RDEPEND}"
