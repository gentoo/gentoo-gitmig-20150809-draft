# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gprs-easy-connect/gprs-easy-connect-3.0.1.ebuild,v 1.1 2007/02/10 08:07:02 mrness Exp $

MY_P="GPRS_Easy_Connect_${PV//./}"

DESCRIPTION="GPRS connection manager"
HOMEPAGE="http://www.gprsec.hu"
SRC_URI="http://www.gprsec.hu/downloads/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/gnome2-perl
	>=dev-perl/gtk2-trayicon-0.03
	net-misc/wget
	net-dialup/ppp"

S="${WORKDIR}/${MY_P}"

src_install(){
	dobin data/bin/gprsec

	insinto /usr/share/applications
	doins "${FILESDIR}/gprsec.desktop"
	insinto /usr/share/icons
	doins data/share/gprsec/images/icons/gprsec.png

	rm data/share/gprsec/doc/gprsec-${PV}/COPYING
	mv data/share/gprsec/doc/gprsec-${PV}/version data/share/gprsec

	insinto /usr/share/doc/gprsec-${PV}
	doins data/share/gprsec/doc/gprsec-${PV}/*
	rm -r data/share/gprsec/doc/gprsec-${PV}

	# Install shared stuff
	insinto /usr/share
	doins -r data/share/gprsec
}
