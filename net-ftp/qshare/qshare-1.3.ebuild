# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/qshare/qshare-1.3.ebuild,v 1.2 2010/06/26 22:19:52 angelos Exp $

EAPI="2"

LANGS="en es fr ru"

inherit qt4-r2

DESCRIPTION="FTP server with a service discovery feature."
HOMEPAGE="http://qt-apps.org/content/show.php/qShare?content=116612"
SRC_URI="http://qt-apps.org/CONTENT/content-files/116612-${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-gui:4"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	#fix translations
	sed -i "s:i18n:usr\/share\/${PN}\/translations:" src/config.cpp \
		|| die "failed to fix translations path"
	qt4-r2_src_prepare
}

src_install() {
	dobin ${PN} || die "dobin failed"
	doicon icons/${PN}.png
	make_desktop_entry /usr/bin/${PN} QShare ${PN} "Qt;Network;FileTransfer"
	dohtml docs/* || die "dohtml failed"
	for X in ${LINGUAS}; do
		for Z in ${LANGS}; do
			if [[ ${X} == ${Z} ]]; then
				insinto /usr/share/${PN}/translations/
				doins i18n/${PN}_${X}.qm || die "failed to install ${X} translation"
			fi
		done
	done
}
