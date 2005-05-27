# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knetload/knetload-3.0_alpha2.ebuild,v 1.4 2005/05/27 16:36:40 flameeyes Exp $

inherit kde

# This is required to make sure rpm are buildable :/
MY_P="${PN}-2.9.92"

DESCRIPTION="Network Load Monitor applet for Kicker with SNMP capabilities"
HOMEPAGE="http://dev.gentoo.org/~flameeyes/kdeapps.xhtml#knetload"
SRC_URI="http://digilander.libero.it/dgp85/files/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="snmp"

DEPEND="snmp? ( >=net-libs/libksnmp-0.3 )"

need-kde 3.2

S=${WORKDIR}/${MY_P}

src_unpack() {
	kde_src_unpack
	rm ${S}/configure
}

src_compile() {
	myconf="--enable-libsuffix= $(use_with snmp libksnmp)"

	kde_src_compile
}
