# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ffmpeg/gst-plugins-ffmpeg-0.8.0.ebuild,v 1.10 2005/04/24 09:47:45 vapier Exp $

#inherit gst-plugins

MY_PN=${PN/-plugins/}
MY_P=${MY_PN}-${PV}

# Create a major/minor combo for SLOT
PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
SLOT=${PVP[0]}.${PVP[1]}

DESCRIPTION="FFmpeg based gstreamer plugin"
SRC_URI="http://gstreamer.freedesktop.org/src/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="ia64 ppc ~sparc x86"
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
