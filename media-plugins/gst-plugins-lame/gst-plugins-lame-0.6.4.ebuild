# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-lame/gst-plugins-lame-0.6.4.ebuild,v 1.7 2004/07/21 00:35:44 eradicator Exp $

IUSE="debug"

inherit gst-plugins

KEYWORDS="x86 ppc sparc"

RDEPEND="media-sound/lame"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

