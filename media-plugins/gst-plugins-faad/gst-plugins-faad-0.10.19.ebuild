# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faad/gst-plugins-faad-0.10.19.ebuild,v 1.4 2011/01/06 16:50:16 armin76 Exp $

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/faad2
	>=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}"
