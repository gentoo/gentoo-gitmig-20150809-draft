# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pango/gst-plugins-pango-0.10.8.ebuild,v 1.3 2006/09/19 19:49:16 agriffis Exp $

inherit gst-plugins-base

KEYWORDS="~alpha ~amd64 ~arm ~hppa ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE=""
RDEPEND="x11-libs/pango
		 >=media-libs/gst-plugins-base-0.10.8"
DEPEND="${RDEPEND}"
