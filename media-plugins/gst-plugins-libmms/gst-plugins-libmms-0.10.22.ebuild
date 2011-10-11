# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libmms/gst-plugins-libmms-0.10.22.ebuild,v 1.6 2011/10/11 19:53:18 jer Exp $

inherit gst-plugins-bad

KEYWORDS="alpha amd64 hppa ~ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.33
	>=media-libs/libmms-0.4"
DEPEND="${RDEPEND}"
