# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-webkit/qt-webkit-4.4.0.ebuild,v 1.2 2008/05/25 08:33:27 corsair Exp $

inherit qt4-build

DESCRIPTION="The Webkit module for the Qt toolkit."
HOMEPAGE="http://www.trolltech.com/"

LICENSE="|| ( QPL-1.0 GPL-3 GPL-2 )"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="~x11-libs/qt-gui-${PV}"
RDEPEND="${DEPEND}"

QT4_TARGET_DIRECTORIES="src/3rdparty/webkit/WebCore tools/designer/src/plugins/qwebview"
QT4_EXTRACT_DIRECTORIES="src/3rdparty/webkit src/3rdparty/sqlite
tools/designer/src/plugins/qwebview"
QCONFIG_ADD="webkit"
QCONFIG_DEFINE="QT_WEBKIT"

src_compile() {
	local myconf
	myconf="${myconf} -webkit"

	qt4-build_src_compile
}
