# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ofa/gst-plugins-ofa-0.10.22.ebuild,v 1.1 2011/07/29 10:54:41 leio Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~amd64-linux ~hppa ~ppc ~ppc64 ~x86 ~x86-linux"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.33
	media-libs/libofa"

DEPEND="${RDEPEND}"
