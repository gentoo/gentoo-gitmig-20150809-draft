# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faac/gst-plugins-faac-0.10.1.ebuild,v 1.3 2006/04/08 12:41:55 dertobi123 Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND="media-libs/faac
		>=media-libs/gst-plugins-base-0.10.3"

DEPEND="${RDEPEND}"
