# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libvisual/gst-plugins-libvisual-0.10.12.ebuild,v 1.2 2007/07/26 13:52:48 gustavoz Exp $

inherit gst-plugins-base

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE=""
RDEPEND=">=media-libs/gst-plugins-base-0.10.12
	 >=media-libs/libvisual-0.2"

DEPEND="${RDEPEND}"
