# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ffmpeg/gst-plugins-ffmpeg-0.8.1.ebuild,v 1.2 2004/08/03 22:40:33 foser Exp $

MY_PN=${PN/-plugins/}
MY_P=${MY_PN}-${PV}

# Create a major/minor combo for SLOT
PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
SLOT=${PVP[0]}.${PVP[1]}

DESCRIPTION="FFmpeg based gstreamer plugin"
LICENSE="GPL-2"
SRC_URI="http://gstreamer.freedesktop.org/src/${MY_PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://gstreamer.freedesktop.org/modules/gst-ffmpeg.html"

KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

S=${WORKDIR}/${MY_P}

DEPEND=">=media-libs/gstreamer-0.8
	dev-util/pkgconfig"

src_compile() {

	econf || die
	emake || die

}

src_install() {

	einstall || die

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
