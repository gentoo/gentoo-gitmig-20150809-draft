# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tunesbrowser/tunesbrowser-0.1.6.ebuild,v 1.2 2004/09/05 07:50:44 seemant Exp $

inherit eutils

SLOT="0"
LICENSE="crazney"
KEYWORDS="~x86"
DESCRIPTION="TunesBrowser is a simple music player, capable of playing music found in iTunes(R) shares"
SRC_URI="http://crazney.net/programs/itunes/files/${P}.tar.bz2
	http://dev.gentoo.org/~squinky86/files/${PV}-gstreamer.patch.bz2"
HOMEPAGE="http://crazney.net/programs/itunes/tunesbrowser.html"
IUSE=""

DEPEND=">=media-libs/gstreamer-0.8
	>=media-plugins/gst-plugins-mad-0.8
	>=media-plugins/gst-plugins-oss-0.8
	media-libs/libopendaap"

src_unpack() {
	unpack ${A}
	cd ${P}.tar.bz2
	epatch ${DISTDIR}/${PV}-gstreamer.patch.bz2
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	einstall || die
}
