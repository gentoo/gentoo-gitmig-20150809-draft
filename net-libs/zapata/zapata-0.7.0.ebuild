# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header $

IUSE=""

inherit eutils

DESCRIPTION="Library of additional telephony related functions"
HOMEPAGE="http://www.asterisk.org"
SRC_URI="ftp://ftp.asterisk.org/pub/telephony/zaptel/zapata-${PV}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	net-misc/zaptel"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-mkdir-usrlib.patch
}

src_compile() {
	emake || die
}

src_install() {
	emake INSTALL_PREFIX=${D} install || die
}
