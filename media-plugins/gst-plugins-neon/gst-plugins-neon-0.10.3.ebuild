# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.3.ebuild,v 1.1 2006/07/20 21:40:53 zaheerm Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 ~x86"

RDEPEND=">=net-misc/neon-0.25.5
	 >=media-libs/gst-plugins-base-0.10.3"

DEPEND="${RDEPEND}"

src_unpack() {
	gst-plugins-bad_src_unpack
	epatch ${FILESDIR}/${P}-neonfix.patch
}
