# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faac/gst-plugins-faac-0.10.1.ebuild,v 1.2 2006/03/29 18:22:03 corsair Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND="media-libs/faac
		>=media-libs/gst-plugins-base-0.10.3"

DEPEND="${RDEPEND}"
