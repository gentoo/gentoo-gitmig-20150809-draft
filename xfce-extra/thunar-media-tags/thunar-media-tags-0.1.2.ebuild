# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-media-tags/thunar-media-tags-0.1.2.ebuild,v 1.3 2007/02/04 19:43:26 chainsaw Exp $

inherit xfce44

xfce44
xfce44_goodies_thunar_plugin

DESCRIPTION="Thunar media tags plugin"

KEYWORDS="~amd64 ~x86 ~ppc64"

DEPEND=">=media-libs/taglib-1.4"
RDEPEND="${RDEPEND}"
