# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-musepack/gst-plugins-musepack-0.10.3.ebuild,v 1.2 2006/07/16 16:35:00 dertobi123 Exp $

inherit gst-plugins-bad

KEYWORDS="alpha ~amd64 ppc ~ppc64 sparc ~x86"

RDEPEND=">=media-libs/gst-plugins-base-0.10.3
	>=media-libs/libmpcdec-1.2"

DEPEND="${RDEPEND}"
