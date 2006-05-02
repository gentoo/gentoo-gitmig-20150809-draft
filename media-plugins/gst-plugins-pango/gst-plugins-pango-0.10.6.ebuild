# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pango/gst-plugins-pango-0.10.6.ebuild,v 1.1 2006/05/02 10:30:44 zaheerm Exp $

inherit gst-plugins-base

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE=""
RDEPEND="x11-libs/pango
		 >=media-libs/gst-plugins-base-0.10.6"
DEPEND="${RDEPEND}"
