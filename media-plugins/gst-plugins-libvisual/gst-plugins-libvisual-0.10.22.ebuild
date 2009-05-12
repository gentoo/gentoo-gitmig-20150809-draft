# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libvisual/gst-plugins-libvisual-0.10.22.ebuild,v 1.2 2009/05/12 20:25:12 fauli Exp $

inherit gst-plugins-base

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.22
	>=media-libs/libvisual-0.4
	>=media-plugins/libvisual-plugins-0.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
