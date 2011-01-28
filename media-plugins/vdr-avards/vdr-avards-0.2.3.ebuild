# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-avards/vdr-avards-0.2.3.ebuild,v 1.3 2011/01/28 17:23:43 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR Plugin:  Automatic Video Aspect Ratio Detection and Signaling"
HOMEPAGE="http://firefly.vdr-developer.org/avards/"
SRC_URI="http://firefly.vdr-developer.org/avards/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin_src_prepare

	sed -i "s:i18n.c:i18n.h:g" Makefile

	if ! has_version ">=media-video/vdr-1.7.13"; then
		sed -i "s:-include \$(VDRDIR)/Make.global:#-include \$(VDRDIR)/Make.global:" Makefile
	fi
}
