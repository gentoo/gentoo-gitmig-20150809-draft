# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-media-tags/thunar-media-tags-0.1.2.ebuild,v 1.7 2007/03/28 17:43:17 gustavoz Exp $

inherit xfce44

xfce44

DESCRIPTION="Thunar media tags plugin"
KEYWORDS="amd64 ~ppc64 ~sparc x86"

RDEPEND=">=media-libs/taglib-1.4"
DEPEND="${RDEPEND}"

xfce44_goodies_thunar_plugin
