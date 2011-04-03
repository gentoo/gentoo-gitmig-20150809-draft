# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quodlibet/quodlibet-2.3.ebuild,v 1.1 2011/04/03 10:31:02 ssuominen Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Ex Falso / Quod Libet - A Music Library/Editor/Player"
HOMEPAGE="http://code.google.com/p/quodlibet/"
SRC_URI="http://quodlibet.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="dbus gstreamer ipod"

COMMON_DEPEND=">=dev-python/pygtk-2"
RDEPEND="${COMMON_DEPEND}
	media-libs/mutagen
	gstreamer? ( dev-python/gst-python:0.10
		media-libs/gst-plugins-good:0.10
		media-plugins/gst-plugins-meta:0.10 )
	!gstreamer? ( media-libs/xine-lib )
	dbus? ( dev-python/dbus-python )
	ipod? ( media-libs/libgpod[python] )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool"

src_prepare() {
	if ! use gstreamer; then
		sed -i -e '/backend/s:gstbe:xinebe:' ${PN}/config.py || die
	fi

	sed -i \
		-e 's/"gst_pipeline": ""/"gst_pipeline": "alsasink"/' \
		${PN}/config.py || die

	distutils_src_prepare
}

src_install() {
	distutils_src_install
	dodoc HACKING NEWS README
	doicon quodlibet/images/{exfalso,quodlibet}.{png,svg}
}
