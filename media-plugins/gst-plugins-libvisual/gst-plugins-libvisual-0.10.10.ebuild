# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libvisual/gst-plugins-libvisual-0.10.10.ebuild,v 1.1 2006/09/15 08:45:45 zaheerm Exp $

inherit gst-plugins-base

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

IUSE=""
RDEPEND=">=media-libs/gst-plugins-base-0.10.10
		 =media-libs/libvisual-0.2*"

DEPEND="${RDEPEND}"
