# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythbrowser/mythbrowser-0.20.1.ebuild,v 1.2 2007/04/27 06:17:08 cardoe Exp $

inherit mythtv-plugins kde-functions multilib

DESCRIPTION="Web browser module for MythTV."
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=kde-base/kdelibs-3.1"
DEPEND="${RDEPEND}"

src_unpack() {
	mythtv-plugins_src_unpack

	set-kdedir
	echo "INCLUDEPATH += ${KDEDIR}/include" >> settings.pro
	echo "EXTRA_LIBS += -L${KDEDIR}/$(get_libdir)" >> settings.pro
}
