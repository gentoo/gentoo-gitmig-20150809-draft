# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faad/gst-plugins-faad-0.10.1.ebuild,v 1.5 2006/04/13 13:34:10 tcort Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND=">=media-libs/faad2-2
	 >=media-libs/gst-plugins-base-0.10.3"

DEPEND="${RDEPEND}"
