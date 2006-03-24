# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.1.ebuild,v 1.1 2006/03/24 11:06:34 zaheerm Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 ~x86"

RDEPEND=">=net-misc/neon-0.25.5
	 >=media-libs/gst-plugins-base-0.10.3"

DEPEND="${RDEPEND}"
