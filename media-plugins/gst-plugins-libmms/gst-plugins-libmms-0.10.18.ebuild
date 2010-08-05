# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libmms/gst-plugins-libmms-0.10.18.ebuild,v 1.7 2010/08/05 20:31:23 ssuominen Exp $

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.27
	>=media-libs/libmms-0.4"
DEPEND="${RDEPEND}"
