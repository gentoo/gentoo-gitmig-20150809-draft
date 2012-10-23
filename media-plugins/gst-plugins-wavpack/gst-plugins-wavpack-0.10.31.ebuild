# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-wavpack/gst-plugins-wavpack-0.10.31.ebuild,v 1.1 2012/10/23 07:58:19 tetromino Exp $

EAPI=4

inherit gst-plugins-good

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86 ~amd64-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.36
	>=media-sound/wavpack-4.40"
DEPEND="${RDEPEND}"
