# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/openmcu/openmcu-1.1.7.ebuild,v 1.1 2003/08/11 00:32:01 tantive Exp $

SRC_URI="http://www.openh323.org/bin/openmcu_${PV}.tar.gz"
HOMEPAGE="http://www.openh323.org"
DESCRIPTION="H.323 conferencing server"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=dev-libs/pwlib-1.5.0
	>=net-libs/openh323-1.12.0"

RDEPEND="${DEPEND}"


src_compile() {
    cd work/openmcu
    OPENH323DIR="/usr/share/openh323" make all || die
}

#src_install() {    
#}