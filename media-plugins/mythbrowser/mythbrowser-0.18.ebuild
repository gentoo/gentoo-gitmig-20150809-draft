# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythbrowser/mythbrowser-0.18.ebuild,v 1.1 2005/04/18 08:26:05 eradicator Exp $

inherit myth kde-functions

DESCRIPTION="Web browser module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/mythplugins-${PV}.tar.bz2"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=sys-apps/sed-4
	>=kde-base/kdelibs-3.1
	|| ( ~media-tv/mythtv-${PV} ~media-tv/mythfrontend-${PV} )"

setup_pro() {
	set-kdedir
	echo "INCLUDEPATH += ${KDEDIR}/include" >> settings.pro
	echo "EXTRA_LIBS += -L${KDEDIR}/lib" >> settings.pro
}

src_compile() {
	myth_src_compile

	# They forgot to put mythbrowser in the normal configure script
	cd ${S}/${PN}
	cp ${S}/settings.pro .
	qmake -o "Makefile" "${S}/${PN}/${PN}.pro"
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" "${@}" || die
}

src_install() {
	myth_src_install

	# They forgot to put mythbrowser in the normal configure script
	cd ${S}/${PN}
	einstall INSTALL_ROOT="${D}"
}
