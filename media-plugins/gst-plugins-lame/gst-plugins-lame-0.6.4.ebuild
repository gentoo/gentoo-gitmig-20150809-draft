# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-lame/gst-plugins-lame-0.6.4.ebuild,v 1.8 2005/03/10 02:03:19 gustavoz Exp $

IUSE="debug"

inherit gst-plugins

KEYWORDS="x86 ppc sparc"

RDEPEND="media-sound/lame"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

