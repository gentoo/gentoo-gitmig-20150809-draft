# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-alsa/gst-plugins-alsa-0.8.7-r1.ebuild,v 1.1 2005/01/17 14:16:30 foser Exp $

inherit eutils gst-plugins

KEYWORDS="~x86 ~ppc ~amd64 ~ia64 ~mips ~hppa ~ppc64 ~sparc"
IUSE=""

DEPEND=">=media-libs/alsa-lib-1.0.7"

src_unpack() {

	gst-plugins_src_unpack

	# fixes http://bugzilla.gnome.org/show_bug.cgi?id=164069
	cd ${S}/ext/alsa
	epatch ${FILESDIR}/${P}-alsa_deadlock.patch

}
