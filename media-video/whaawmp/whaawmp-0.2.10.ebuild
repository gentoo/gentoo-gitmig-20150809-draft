# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/whaawmp/whaawmp-0.2.10.ebuild,v 1.1 2008/09/24 10:44:20 yngwin Exp $

inherit distutils

DESCRIPTION="Whaaw! Media Player is a lightweight audio/video player"
HOMEPAGE="http://home.gna.org/whaawmp"
SRC_URI="http://download.gna.org/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus"

# Upstream requires gst-plugins-good as a minimum
# Depending on the desired video (and audio) playback support, users will need
# to set USE flags for the -meta ebuild, as everything it supports can be used,
# like DVD playback, especially. No support yet for audio CDs, but I'm kinda
# working with upstream to add such features.
RDEPEND=">=dev-lang/python-2.5
	dev-python/gst-python
	dev-python/pyxdg
	media-libs/gst-plugins-good
	media-plugins/gst-plugins-meta
	dbus? ( dev-python/dbus-python )"

DEPEND="dev-util/intltool
	sys-devel/gettext"

distutils_src_unpack() {
	unpack ${A}
	cd "${S}"
	ln -s make.py setup.py
}

pkg_postinst() {
	elog "Depending on the audio/video playback capabilities"
	elog "you want, you'll need to set appropriate USE flags"
	elog "for media-libs/gst-plugins-good and"
	elog "media-plugins/gst-plugins-meta in /etc/portage/package.use"
	elog ""
}
