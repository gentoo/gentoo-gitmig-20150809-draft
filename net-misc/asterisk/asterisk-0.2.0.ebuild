# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 

S=${WORKDIR}/${P}
DESCRIPTION="Asterisk - Full PBX in Software"
HOMEPAGE="http://www.asterisk.org"
SRC_URI="ftp://ftp.asterisk.org/pub/${PN}/${P}.tar.gz"
LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="virtual/glibc
		=sys-apps/sed-4*
		doc? ( app-doc/doxygen )"

src_compile() {

	emake || die

	# One small error in Makefile
	sed -i 's:mkdir -p /etc/asterisk:mkdir -p $(INSTALL_PREFIX)/etc/asterisk:' \
		${S}/Makefile
}

src_install () {

	make INSTALL_PREFIX=${D} install || die
	make INSTALL_PREFIX=${D} samples || die
	use doc && make INSTALL_PREFIX=${D} progdocs
}
