# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-lame/gst-plugins-lame-0.6.4.ebuild,v 1.6 2004/06/24 23:30:13 agriffis Exp $

inherit gst-plugins

KEYWORDS="x86 ppc sparc"

IUSE=""
RDEPEND="media-sound/lame"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

