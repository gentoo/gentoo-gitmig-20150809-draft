# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/arista/arista-0.9.3-r1.ebuild,v 1.6 2011/02/01 05:48:04 ford_prefect Exp $

EAPI=2

inherit distutils

DESCRIPTION="An easy to use multimedia transcoder for the GNOME Desktop"
HOMEPAGE="http://programmer-art.org/projects/arista-transcoder"
SRC_URI="http://programmer-art.org/media/releases/arista-transcoder/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
# Making these USE-defaults since encoding for portable devices is a very
# common use case for Arista. xvid is being added since it's required for
# DVD ripping. No gst-plugins-x264 available at this time.
IUSE="+faac +xvid"

DEPEND="dev-python/setuptools"
RDEPEND="dev-lang/python[xml]
	>=x11-libs/gtk+-2.16
	>=dev-python/pygtk-2.14
	dev-python/pygobject
	dev-python/pycairo
	dev-python/gconf-python
	dev-python/dbus-python
	>=media-libs/gstreamer-0.10.22
	dev-python/gst-python
	media-libs/gst-plugins-base:0.10
	media-libs/gst-plugins-good:0.10
	media-libs/gst-plugins-bad
	media-plugins/gst-plugins-meta:0.10
	media-plugins/gst-plugins-ffmpeg:0.10
	faac? ( media-plugins/gst-plugins-faac:0.10 )
	xvid? ( media-plugins/gst-plugins-xvid:0.10 )"

pkg_postinst() {
	einfo "If you find that a format you want is not supported in Arista,"
	einfo "please make sure that you have the corresponding USE-flag enabled"
	einfo "media-plugins/gst-plugins-meta"
}
