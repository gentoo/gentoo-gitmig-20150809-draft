# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-taglib/gst-plugins-taglib-0.10.22.ebuild,v 1.4 2010/08/05 20:37:28 ssuominen Exp $

inherit gst-plugins-good

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.29
	>=media-libs/taglib-1.5"
DEPEND="${RDEPEND}"
