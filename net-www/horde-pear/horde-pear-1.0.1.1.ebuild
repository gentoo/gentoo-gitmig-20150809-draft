# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-pear/horde-pear-1.0.1.1.ebuild,v 1.1 2003/05/12 18:37:35 alron Exp $

DESCRIPTION="Horde Application Framework PHP PEAR files ${PV}"
HOMEPAGE="http://www.horde.org"
P="pear-1.0.1.1"
SRC_URI="ftp://ftp.horde.org/pub/pear/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND=""
RDEPEND=">=dev-php/mod_php-4.1.0
         >=sys-devel/gettext-0.10.40
         >=dev-libs/libxml2-2.4.21-r1"
IUSE=""
S="${WORKDIR}/pear"
src_compile() {
	#nothing to compile
	echo "Nothing to compile"
}

src_install () {
	mkdir -p ${D}/usr/lib
	cp -a ${S} ${D}/usr/lib/php
}
