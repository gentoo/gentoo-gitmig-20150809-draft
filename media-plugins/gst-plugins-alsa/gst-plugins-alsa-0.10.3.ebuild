# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-alsa/gst-plugins-alsa-0.10.3.ebuild,v 1.1 2006/02/10 13:08:58 zaheerm Exp $

inherit eutils gst-plugins-base

KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=media-libs/alsa-lib-1.0.7
	 >=media-libs/gst-plugins-base-0.10.3"
