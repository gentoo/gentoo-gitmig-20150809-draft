# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-alsa/gst-plugins-alsa-0.8.5-r1.ebuild,v 1.1 2004/11/18 14:29:42 foser Exp $

inherit gst-plugins eutils

KEYWORDS="~x86 ~ppc ~amd64 ~ia64 ~mips ~hppa ~ppc64"
IUSE=""

DEPEND=">=media-libs/alsa-lib-1.0.7"

src_unpack() {

	gst-plugins_src_unpack

	epatch ${FILESDIR}/${P}-cvs_fixes.patch

}
