# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header $

IUSE=""

DESCRIPTION="Primary Rate ISDN (PRI) library"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="ftp://ftp.asterisk.org/pub/telephony/libpri/libpri-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install() {
	make INSTALL_PREFIX=${D} install || die

	dodoc ChangeLog README TODO
}
