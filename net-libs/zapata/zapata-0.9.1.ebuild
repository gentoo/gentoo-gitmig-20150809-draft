# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/zapata/zapata-0.9.1.ebuild,v 1.4 2004/07/26 22:35:59 stkn Exp $

IUSE=""

inherit eutils

DESCRIPTION="Library of additional telephony related functions"
HOMEPAGE="http://www.asterisk.org"
SRC_URI="ftp://ftp.asterisk.org/pub/telephony/zaptel/old/zapata-${PV}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"

DEPEND="virtual/libc
	=net-misc/zaptel-0.9.1"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-mkdir-usrlib.patch
	epatch ${FILESDIR}/${PN}-mkdir-usrinclude.patch
}

src_compile() {
	emake || die
}

src_install() {
	emake INSTALL_PREFIX=${D} install || die
}
