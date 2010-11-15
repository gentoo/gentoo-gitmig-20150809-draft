# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qt-recordmydesktop/qt-recordmydesktop-0.3.8-r1.ebuild,v 1.1 2010/11/15 20:38:20 radhermit Exp $

EAPI="2"

inherit qt4-r2 eutils

DESCRIPTION="QT4 interface for RecordMyDesktop"
HOMEPAGE="http://recordmydesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/recordmydesktop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
# Test is buggy : bug #186752
# Tries to run intl-toolupdate without it being substituted from
# configure, make test tries run make check in flumotion/test what
# makes me think that this file has been copied from flumotion without
# much care...
RESTRICT="test"

RDEPEND="x11-libs/qt-gui:4
	>=dev-python/PyQt4-4.1[X]
	>=media-video/recordmydesktop-0.3.8
	x11-apps/xwininfo"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-check-for-jack.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS README AUTHORS ChangeLog
}
