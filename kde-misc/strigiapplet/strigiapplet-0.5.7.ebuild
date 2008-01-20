# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/strigiapplet/strigiapplet-0.5.7.ebuild,v 1.1 2008/01/20 21:10:53 philantrop Exp $

inherit kde multilib cmake-utils

DESCRIPTION="KDE kicker applet to use strigi."
HOMEPAGE="http://www.vandenoever.info/software/strigi"
SRC_URI="http://www.vandenoever.info/software/strigi/${P}.tar.bz2"
LICENSE="LGPL-2"

SLOT="3.5"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="~app-misc/strigi-${PV}
		>=app-text/poppler-0.5.3
		>=media-libs/libextractor-0.5.15"
RDEPEND="${DEPEND}
		|| ( =kde-base/kdebase-3.5* =kde-base/kicker-3.5* )"

need-kde 3.5

src_compile() {
	# Fix multi-lib issues
	sed -i -e "/SET (LIB_DESTINATION/s:\"lib\":\"$(get_libdir)\":" \
		"${S}"/CMakeLists.txt || die "sed 1 for multilib failed"
	sed -i -e "/LIBRARY DESTINATION/s:lib/kde3:$(get_libdir)/kde3:" \
		"${S}"/src/strigi/CMakeLists.txt || die "sed 2 for multilib failed"
	sed -i -e "/LIBRARY DESTINATION/s:lib/kde3:$(get_libdir)/kde3:" \
		"${S}"/src/kickerapplet/CMakeLists.txt || die "sed 3 for multilib failed"
	sed -i -e "/LIBRARY DESTINATION/s:lib/kde3:$(get_libdir)/kde3:" \
		"${S}"/src/jstream/CMakeLists.txt || die "sed 4 for multilib failed"
	sed -i -e "/LIBRARY DESTINATION/s:lib/strigi:$(get_libdir)/strigi:" \
		"${S}"/src/streamindexer/libextractor/CMakeLists.txt || die "sed 5 for multilib failed"
	sed -i -e "/LIBRARY DESTINATION/s:lib/strigi:$(get_libdir)/strigi:" \
		"${S}"/src/streamindexer/kfile/CMakeLists.txt || die "sed 7 for multilib failed"
	sed -i -e "/LIBRARY DESTINATION/s:lib/strigi:$(get_libdir)/strigi:" \
		"${S}"/src/streamindexer/pdf/CMakeLists.txt || die "sed 8 for multilib failed"

	# Fix the desktop file
	sed -i -e "/Exec=/s:'::g" "${S}"/src/strigi/strigi.desktop \
		|| die "sed to fix the desktop file failed"

	# Fix Qt libraries not being found
	sed -i -r -e 's:find_package(KDE3 REQUIRED):\1\nfind_package(Qt3 REQUIRED):' \
		"${S}"/CMakeLists.txt || die "sed to include find_package(Qt3) failed."
	sed -i -e 's:qt-mt:${QT_LIBRARIES}:' \
		"${S}"/src/kickerapplet/CMakeLists.txt || die "sed to link libqt-mt.so failed."

	cmake-utils_src_compile
}
