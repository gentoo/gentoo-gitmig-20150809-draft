# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pulse/gst-plugins-pulse-0.9.7.ebuild,v 1.7 2008/11/18 13:22:11 lack Exp $

MY_PN=gst-pulse

DESCRIPTION="gst-pulse is a GStreamer 0.10 plugin for the PulseAudio sound server."
HOMEPAGE="http://0pointer.de/lennart/projects/gst-pulse/"
SRC_URI="http://0pointer.de/lennart/projects/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0.10"
KEYWORDS="alpha amd64 sparc x86"
IUSE=""

RDEPEND=">=media-sound/pulseaudio-${PV}
	=media-libs/gstreamer-0.10*
	>=media-libs/gst-plugins-base-0.10.20"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}"/${MY_PN}-${PV}

src_compile() {
	econf --disable-lynx
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dohtml -r doc
	dodoc README
}
