# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/qshare/qshare-2.1.2.ebuild,v 1.1 2012/01/19 10:52:50 johu Exp $

EAPI=4

LANGS="en es fr ru"

inherit eutils qt4-r2

DESCRIPTION="FTP server with a service discovery feature."
HOMEPAGE="http://www.zuzuf.net/qshare/"
SRC_URI="http://www.zuzuf.net/qshare/files/${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-dns/avahi[mdnsresponder-compat]
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i "s:i18n:usr\/share\/${PN}\/translations:" src/config.cpp \
		|| die "failed to fix translations path"
	qt4-r2_src_prepare
}

src_install() {
	dobin ${PN}
	doicon icons/${PN}.png
	make_desktop_entry /usr/bin/${PN} QShare ${PN} "Qt;Network;FileTransfer"
	dodoc AUTHORS README
	dohtml docs/*
	for X in ${LINGUAS}; do
		for Z in ${LANGS}; do
			if [[ ${X} == ${Z} ]]; then
				insinto /usr/share/${PN}/translations/
				doins i18n/${PN}_${X}.qm
			fi
		done
	done
}
