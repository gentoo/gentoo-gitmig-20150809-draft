# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk/asterisk-0.2.0.ebuild,v 1.10 2004/06/24 23:34:54 agriffis Exp $

IUSE="doc"

S=${WORKDIR}/${P}
DESCRIPTION="Asterisk - Full PBX in Software"
HOMEPAGE="http://www.asterisk.org"
SRC_URI="ftp://ftp.asterisk.org/pub/telephony/${PN}/old-releases/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc
		=sys-apps/sed-4*
		doc? ( app-doc/doxygen )"

src_compile() {

	emake -j1 || die

	# One small error in Makefile
	sed -i 's:mkdir -p /etc/asterisk:mkdir -p $(INSTALL_PREFIX)/etc/asterisk:' \
		${S}/Makefile
}

src_install () {

	make INSTALL_PREFIX=${D} install || die
	make INSTALL_PREFIX=${D} samples || die
	use doc && make INSTALL_PREFIX=${D} progdocs
}
