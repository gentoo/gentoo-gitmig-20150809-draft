# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-alsa/gst-plugins-alsa-0.8.2-r1.ebuild,v 1.9 2004/11/08 18:14:11 vapier Exp $

inherit gst-plugins eutils

KEYWORDS="x86 ppc amd64 ia64 mips hppa ppc64"
IUSE=""

# should we depend on a kernel (?)
DEPEND=">=media-libs/alsa-lib-0.9.1"

src_unpack() {

	gst-plugins_src_unpack

	# fixes alsa seek/drag problem (#56215)
	epatch ${FILESDIR}/${P}-alsasink_seek_fix.patch

}

pkg_postinst() {

	gst-plugins_pkg_postinst

	ewarn "This plugin has known problems on some hardware due to alsa bugs"

}
