# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knetload/knetload-3.0_alpha2.ebuild,v 1.2 2005/05/07 17:54:56 flameeyes Exp $

inherit kde

# This is required to make sure rpm are buildable :/
MY_P="${PN}-2.9.92"

DESCRIPTION="Network Load Monitor applet for Kicker with SNMP capabilities"
HOMEPAGE="http://dev.gentoo.org/~flameeyes/kdeapps.xhtml#knetload"
SRC_URI="http://digilander.libero.it/dgp85/files/${MY_P}.tar.bz2"

RDEPEND="$RDEPEND
	snmp? ( >=net-libs/libksnmp-0.3 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="snmp"

S=${WORKDIR}/${MY_P}

need-kde 3.2

src_compile() {
	myconf="--enable-libsuffix= $(use_with snmp libksnmp)"

	kde_src_compile
}