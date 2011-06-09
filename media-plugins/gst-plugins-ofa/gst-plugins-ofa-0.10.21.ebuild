# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ofa/gst-plugins-ofa-0.10.21.ebuild,v 1.1 2011/06/09 19:34:40 beandog Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.21
	media-libs/libofa"

DEPEND="${RDEPEND}"
