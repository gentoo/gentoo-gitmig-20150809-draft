# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ffmpeg/gst-plugins-ffmpeg-0.8.3.ebuild,v 1.3 2005/01/13 21:09:15 foser Exp $

inherit flag-o-matic

MY_PN=${PN/-plugins/}
MY_P=${MY_PN}-${PV}

# Create a major/minor combo for SLOT
PVP=(${PV//[-\._]/ })
SLOT=${PVP[0]}.${PVP[1]}

DESCRIPTION="FFmpeg based gstreamer plugin"
LICENSE="GPL-2"
SRC_URI="http://gstreamer.freedesktop.org/src/${MY_PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://gstreamer.freedesktop.org/modules/gst-ffmpeg.html"

KEYWORDS="x86 ~ppc ~sparc ~amd64"
IUSE=""

S=${WORKDIR}/${MY_P}

DEPEND=">=media-libs/gstreamer-0.8.4
	dev-util/pkgconfig"

src_compile() {

	# Restrictions taken from the mplayer ebuild
	# See bug #64262 for more info
	# let's play the filtration game!
	filter-flags -fPIE -fPIC -fstack-protector -fforce-addr -momit-leaf-frame-pointer -msse2 -msse3 -falign-functions
	# ugly optimizations cause MPlayer to cry on x86 systems!
	if use x86 ; then
		replace-flags -O0 -O2
		replace-flags -O3 -O2
	fi

	econf || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO

}

# ripped from the gst-plugins eclass
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
