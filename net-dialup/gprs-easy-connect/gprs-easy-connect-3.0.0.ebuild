# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gprs-easy-connect/gprs-easy-connect-3.0.0.ebuild,v 1.1 2006/10/06 22:15:33 mrness Exp $

MY_P="GPRS_Easy_Connect_${PV//./}"

DESCRIPTION="GPRS connection manager"
HOMEPAGE="http://www.gprsec.hu"
SRC_URI="http://www.gprsec.hu/downloads/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-perl/gnome2-perl
	>=dev-perl/gtk2-trayicon-0.03
	net-misc/wget
	net-dialup/ppp"

S="${WORKDIR}/${MY_P}"

src_install(){
	dodoc data/share/gprsec/README
	dohtml documentation.html

	dobin data/bin/gprsec

	insinto /usr/share/applications
	doins "${FILESDIR}/gprsec.desktop"
	insinto /usr/share/icons
	doins data/share/gprsec/images/icons/*

	insinto /usr/share
	rm data/share/gprsec/{README,COPYING,GNU_GPL_HU}
	doins -r data/share/gprsec
}
