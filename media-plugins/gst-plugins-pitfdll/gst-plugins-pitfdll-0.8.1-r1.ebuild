# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pitfdll/gst-plugins-pitfdll-0.8.1-r1.ebuild,v 1.2 2005/06/05 18:55:47 foser Exp $

inherit eutils

DESCRIPTION="GStreamer plugin for Win32 DLL loading"
HOMEPAGE="http://ronald.bitfreak.net/pitfdll.php"

MY_PN=${PN/gst-plugins-/}
MY_P=${MY_PN}-${PV}

SRC_URI="mirror://sourceforge/$MY_PN/$MY_P.tar.bz2"

# Create a major/minor combo for SLOT - stolen from gst-plugins-ffmpeg
PVP=(${PV//[-\._]/ })
SLOT=${PVP[0]}.${PVP[1]}

LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

S=${WORKDIR}/${MY_P}

DEPEND=">=media-libs/gstreamer-0.8.9
		>=media-libs/gst-plugins-0.8.8-r1"
RDEPEND="$DEPEND
	media-libs/win32codecs"

src_unpack() {
	unpack ${A}
	cd ${S}/ext/pitfdll
	epatch ${FILESDIR}/${P}-mutex.patch
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}

# ripped from gst-plugins.eclass
update_registry() {
	einfo "Updating gstreamer plugins registry for gstreamer ${SLOT}..."
	gst-register-${SLOT}
}

pkg_postinst() {
	update_registry
}

pkg_postrm() {
	update_registry
}
