# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythbrowser/mythbrowser-0.16.ebuild,v 1.4 2004/12/05 00:57:55 iggy Exp $

inherit myth

DESCRIPTION="Web browser module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"
IUSE="debug nls"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"

DEPEND=">=sys-apps/sed-4
	>=kde-base/kdelibs-3.1
	|| ( ~media-tv/mythtv-${PV} ~media-tv/mythfrontend-${PV} )"

setup_pro() {
	echo "INCLUDEPATH += ${KDEDIR}/include" >> settings.pro
	echo "EXTRA_LIBS += -L${KDEDIR}/lib" >> settings.pro
}
