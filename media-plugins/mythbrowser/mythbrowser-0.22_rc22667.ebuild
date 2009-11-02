# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythbrowser/mythbrowser-0.22_rc22667.ebuild,v 1.1 2009/11/02 02:09:21 cardoe Exp $

EAPI=2
inherit qt4 mythtv-plugins kde-functions

DESCRIPTION="Web browser module for MythTV."
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=x11-libs/qt-webkit-4.5:4"
DEPEND="${RDEPEND}"

src_prepare() {
	mythtv-plugins_src_prepare || die "mythplugins prepare failed"

	set-kdedir
	echo "INCLUDEPATH += ${KDEDIR}/include" >> settings.pro
	echo "EXTRA_LIBS += -L${KDEDIR}/$(get_libdir)" >> settings.pro
}
